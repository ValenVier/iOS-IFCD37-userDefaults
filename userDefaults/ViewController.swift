//
//  ViewController.swift
//  userDefaults
//
//  Created by Javier Rodríguez Valentín on 28/09/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var inputPassword: UITextField!
    
    @IBOutlet weak var getButt: UIButton!
    @IBOutlet weak var addButt: UIButton!
    @IBOutlet weak var eraseButt: UIButton!
    
    let key1 = "NOMBRE:"
    let key2 = "APELLIDOS:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Introduzca su nombre"
        input.attributedPlaceholder = NSAttributedString(string: "Nombre",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        labelPassword.text = "Introduzca su password"
        inputPassword.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        /*los redondeos se han añadido en la parte de custom class de cada boton pero se deja el código. además hay que activar clips to bounds de los botones*/
        //getButt.layer.cornerRadius = 10
        //addButt.layer.cornerRadius = 10
        //eraseButt.layer.cornerRadius = 10
        
        
    }
    
    
    @IBAction func getButton(_ sender: Any) {
        //como la función del botón no retorna, es necesario llamar a una función get que nos retorne el dato almacenado
        let data = get(key1: key1, key2: key2)
        alert(msg: "Se han guardado: Nombre: \(data.0) y Password: \(data.1)")
    }
    
    func get(key1:String, key2:String) -> (String, String) {
        if let data1 = UserDefaults.standard.string(forKey: key1), let data2 = UserDefaults.standard.string(forKey: key2){
            return (data1, data2)
        }
        return ("Error:", "No hay datos almacenados")
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        if input.text != "" && inputPassword.text != "" {
            UserDefaults.standard.set(input.text, forKey: key1)
            UserDefaults.standard.set(inputPassword.text, forKey: key2)
            UserDefaults.standard.synchronize()
            let dataName = get(key1: key1, key2: key2)
            alert(msg: "Dato guardado \(dataName)")
        }else{
            if input.text == "" && inputPassword.text == ""{
                alert(msg: "No ha introducido ningun dato")
            }else if input.text == ""{
                alert(msg: "No ha introducido el nombre")
            }else if inputPassword.text == ""{
                alert(msg: "No ha introducido el password")
            }else{
                alert(msg: "Error")
            }
        }
        
    }
    
    @IBAction func eraseButton(_ sender: Any) {
        let dataE = get(key1: key1, key2: key2)
        UserDefaults.standard.removeObject(forKey: key1)
        UserDefaults.standard.set(inputPassword.text, forKey: key2)
        UserDefaults.standard.synchronize()
        alert(msg: "Dato borrado: \(dataE)")
        
    }
    
    func alert(msg:String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert, animated: true, completion: {/*Para poner el temporizador, se puede poner nil*/ Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })})
    }
}

