//
//  JsonClass.swift
//  Viajes_Compartidos
//
//  Created by ADMN on 3/11/20.
//  Copyright © 2020 ADMN. All rights reserved.
//
import UIKit
class Conexionput: NSObject {

//constantes de nuestra clase
//let urlBase = ".-,"//url del servidor remoto
//let urlBase = "https://appis-polar.expressmyapp.com/api"//url del servidor remoto
   // let urlBase = "https://appis-test-polar.polar.house/api"
 let urlBase = "https://appis.eduflix.online/api"//url del servidor remoto

//funcion recibe el array JSON desde el servidor remoto y lo convierte en array tipo NSArray
/*los parametros de entrada son:
url -> nombre del archivo .php que va a procesar nuestra solicitud
datos_enviados -> array de datos que vamos a enviar via POST
*/

func arrayFromJson(url2:String,datos_enviados:NSMutableDictionary, comletionHandler: @escaping (Any) -> Void){
    //print(datos_enviados)

        //Concatenamos nuestr url base con el archivo .php que va a procesar la solicitud
        let url = URL(string: "\(urlBase)/\(url2)")!
        //convertimos la constante url a tipo URLRequest
        var request = URLRequest(url: url)
 

             //establecemos las cabeceras de la petición JSON estándar
             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             request.httpMethod = "PUT"//puede ser GET pero por seguridad siempre sera POST
         
             /*
             En las siguientes 4 lineas vamos a concatenar o empujar nuevos valores al array de datos que enviaremos al servidor remoto.
             NOTA. Aquí puedes concatenar otros valores que consideres necesarios para la solicitud por ejemplo
             *latitud, longitud y altitud del usuario
             *fecha local del dispositivo
             *Medidas de los sensores (Acelerómetro. giroscopio, sensor de luz, etc)
             */
    
         
             //Convertimos  el array en formato JSON antes de ser enviada
           request.httpBody = try! JSONSerialization.data(withJSONObject: datos_enviados)

             //realizamos la petición al servidor remoto
         
             let task = URLSession.shared.dataTask(with: request) { datos_recibidos, response, error in
                 if error != nil{//detectamos un error y devolvemos el array vacío
                    print("ocurrio un error")
                 }
                 else{
                                         //tratamos de convertir la respuesta en array
                                         do {
                                             //imprimimos en consola los datos enviados y los datos recibidos en modo debug
                                           print("datos recibidos: \(String(describing: String(data: datos_recibidos!, encoding: .utf8))) - datos enviados: \(datos_enviados)")
                                          
                                            let dataString = String(data: datos_recibidos!, encoding: String.Encoding.utf8)
                                            
                                            comletionHandler(dataString as Any)
return
                                            //let jsonObjectData = dataString!.data(using: .utf8)!
                                            
                                            
                                          //  let json = try? JSONSerialization.jsonObject(with: datos_recibidos!, options: [])
                                            
                                          
            

                                            
                                    
                                        
                                    
                                       
                                         } catch _ {
                                             //Existe un error en el formato JSON, imprimimos en consola la respuesta para localizar el error
                                             //detectamos un error y devolvemos el array vacío


                                         }
                                     }
                                 }
                                 task.resume()
                           
                         }
                         
                     }

