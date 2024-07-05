/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.bdapp.view;
import edu.mx.uttt.bdapp.control.CtrlCliente;
import edu.mx.uttt.bdapp.entidades.Cliente;
/**
 *
 * @author DEIMO
 */
public class VistaCliente {
    public static void main(String[] args) {
        Cliente cli = new Cliente();
                cli.setCustomerId("XYZ");
                cli.setCompanyName("Patito hule");
                cli.setContactName(" ");
        CtrlCliente  ctrlCli= new CtrlCliente();
        ctrlCli.agregar(cli);
    }
}
