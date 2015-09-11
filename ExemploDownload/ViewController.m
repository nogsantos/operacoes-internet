//
//  ViewController.m
//  ExemploDownload
//
//  Created by Fabricio Nogueira dos Santos on 9/10/15.
//  Copyright (c) 2015 Fabricio Nogueira. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 * Método para salvar o arquivo no diretório de documentos
 */
-(NSString *) downloadSavePathFor:(NSString *) filename {
    
    NSArray  *paths         = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:filename];
}
/**
 * Mostra uma mensagem
 */
-(void) showMessage:(NSString *) message {
    
    UIAlertView *alert = [
                          [UIAlertView alloc]
                          initWithTitle:@"Aviso"
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil
                          ];
    
    [alert show];
}
/**
 * Realiza o download do arquivo de acordo com a url informada.
 */
- (IBAction)startDownload:(id)sender {
    /*
     * Instancia dos objetos para enviar ou receber dados.
     */
    NSURL        *url          = [NSURL URLWithString:_downloadField.text];
    // o objeto encapsula todos os métodos de uma requisição HTTP, os headers e corpo da requisição.
    NSURLRequest *request      = [NSURLRequest requestWithURL:url];
    NSString     *saveFilename = [self downloadSavePathFor:url.lastPathComponent];
    
    NSLog(@"Salvando o arquivo em %@", saveFilename);
    /*
     * Incialização do objeto que irá lidar com a requisição em si.
     */
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:saveFilename append:NO];
    /*
     * Blocks: são objetos que contêm um comportamento específico, que será executado em um determinado momento.
     */
    [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *op, NSHTTPURLResponse *response) {
         [_loading stopAnimating];
         _loading.hidden = YES;
         [self showMessage:@"Download finalizado com sucesso"];
     }failure:^(AFHTTPRequestOperation *op, NSError *error) {
         [self showMessage:[NSString stringWithFormat:@"Erro no download: %@",[error localizedDescription]]];
     }];
    /*
     * Operação que será executada.
     * Atualização da barra de progresso ao receber dados do servidor.
     */
    [operation setDownloadProgressBlock: ^(NSUInteger read, long long totalRead, long long totalExpected) {
         _progressBar.progress = (float)totalRead / (float)totalExpected;
     }];
    
    _progressBar.hidden   = NO;
    _progressBar.progress = 0;
    _loading.hidden       = NO;
    [_loading startAnimating];
    
    [operation start];
}
@end
