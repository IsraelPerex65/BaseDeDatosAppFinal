/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.bdapp.model;

import edu.mx.uttt.bdapp.entidades.Cliente;
import edu.mx.uttt.bdapp.entidades.Cliente;

/**
 *
 * @author DEIMO
 */
public class ModelCliente {

    public static boolean agregar(Cliente cli) {
        String resultado = "\nClave del cliente: " + cli.getCustomerId()
                + "\nnombre del cliente: " + cli.getCompanyName()
                + "\nnombre del contacto: "
                + (cli.getContactName().equals(" ") ? "Null" : cli.getContactName())
                + "\nnombre del titulo" + (cli.getContactTitle().equals(" ") ? "Null" : cli.getContactTitle());
        return true;
    }
}
