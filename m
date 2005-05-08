From: bs.x.ttp@recursor.net
Subject: a7n8x SATA Problem
Date: Sun, 8 May 2005 23:14:59 +0000 (UTC)
Message-ID: <200505082320.j48NKk6j022165@gourmet.spamgourmet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gourmet.spamgourmet.com ([216.218.230.146]:62149 "EHLO
	gourmet.spamgourmet.com") by vger.kernel.org with ESMTP
	id S263006AbVEHXUu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 May 2005 19:20:50 -0400
Received: from gourmet.spamgourmet.com (localhost [127.0.0.1])
	by gourmet.spamgourmet.com (8.12.11/8.12.11) with ESMTP id j48NKm2b022184
	for <linux-ide@vger.kernel.org>; Sun, 8 May 2005 16:20:48 -0700
Received: (from jqh1@localhost)
	by gourmet.spamgourmet.com (8.12.11/8.12.11/Submit) id j48NKmv5022183
	for linux-ide@vger.kernel.org; Sun, 8 May 2005 16:20:48 -0700
Date: Tue, 10 May 2005 01:20:54 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, 


I need some help for reporting a bug to ASUS, because i do not understand what exactly is

causing the problem. Though there are similar problem descriptions in the kernel bug list 

and on the kernel list, the kernel does not seem to be the cause here.



--- PROBLEM DESCRIPTION ---

 Opperation of boot loaders (both GRUB and LILO) slows down extremely (~ 15 minutes for loading 
 
 the kernel from disk.  Stage2 loads approx. 2 minutes for GRUB; In normal opperation the times 
 
 are negligible).

 But no errors occure here.


 Then (kernel: 2.6.11.3, kompiled with noapic): 
   
   * After booting from a PATA disk with sata_sil compiled as module, modprobe sata_sil 
 
     gives the following and no SATA devices are recognized:
 
--- BEGIN OUTPUT ---
 
kernel: SCSI subsystem initialized
kernel: libata version 1.10 loaded.
kernel: sata_sil version 0.8
kernel: irq 11: nobody cared!
kernel:  [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
kernel:  [handle_IRQ_event+48/112] handle_IRQ_event+0x30/0x70
kernel:  [note_interrupt+108/208] note_interrupt+0x6c/0xd0
kernel:  [__do_IRQ+304/352] __do_IRQ+0x130/0x160
kernel:  [do_IRQ+25/48] do_IRQ+0x19/0x30
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [__do_softirq+48/144] __do_softirq+0x30/0x90
kernel:  [do_softirq+38/48] do_softirq+0x26/0x30
kernel:  [irq_exit+52/64] irq_exit+0x34/0x40
kernel:  [do_IRQ+30/48] do_IRQ+0x1e/0x30
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [pci_conf1_write+130/224] pci_conf1_write+0x82/0xe0
kernel:  [acpi_os_write_pci_configuration+119/133] acpi_os_write_pci_configuration+0x77/0x85
kernel:  [acpi_ex_pci_config_space_handler+77/90] acpi_ex_pci_config_space_handler+0x4d/0x5a
kernel:  [acpi_ex_pci_config_space_handler+0/90] acpi_ex_pci_config_space_handler+0x0/0x5a
kernel:  [acpi_ev_address_space_dispatch+211/297] acpi_ev_address_space_dispatch+0xd3/0x129
kernel:  [acpi_ex_access_region+71/148] acpi_ex_access_region+0x47/0x94
kernel:  [acpi_ex_field_datum_io+301/453] acpi_ex_field_datum_io+0x12d/0x1c5
kernel:  [acpi_ex_write_with_update_rule+233/244] acpi_ex_write_with_update_rule+0xe9/0xf4
kernel:  [acpi_ex_insert_into_field+227/594] acpi_ex_insert_into_field+0xe3/0x252
kernel:  [acpi_ns_search_parent_tree+61/94] acpi_ns_search_parent_tree+0x3d/0x5e
kernel:  [acpi_ex_write_data_to_field+520/558] acpi_ex_write_data_to_field+0x208/0x22e
kernel:  [acpi_ex_store_object_to_node+98/162] acpi_ex_store_object_to_node+0x62/0xa2
kernel:  [acpi_ex_store+50/258] acpi_ex_store+0x32/0x102
kernel:  [acpi_ex_opcode_1A_1T_1R+1201/1495] acpi_ex_opcode_1A_1T_1R+0x4b1/0x5d7
kernel:  [acpi_ex_resolve_operands+747/790] acpi_ex_resolve_operands+0x2eb/0x316
kernel:  [acpi_ds_exec_end_op+173/691] acpi_ds_exec_end_op+0xad/0x2b3
kernel:  [acpi_ps_parse_loop+1347/2140] acpi_ps_parse_loop+0x543/0x85c
kernel:  [acpi_ps_parse_aml+78/439] acpi_ps_parse_aml+0x4e/0x1b7
kernel:  [acpi_psx_execute+346/448] acpi_psx_execute+0x15a/0x1c0
kernel:  [acpi_ns_execute_control_method+59/72] acpi_ns_execute_control_method+0x3b/0x48
kernel:  [acpi_ns_evaluate_by_handle+118/141] acpi_ns_evaluate_by_handle+0x76/0x8d
kernel:  [acpi_ns_evaluate_relative+169/197] acpi_ns_evaluate_relative+0xa9/0xc5
kernel:  [acpi_rs_set_srs_method_data+155/179] acpi_rs_set_srs_method_data+0x9b/0xb3
kernel:  [acpi_pci_link_set+233/355] acpi_pci_link_set+0xe9/0x163
kernel:  [acpi_pci_link_allocate+155/245] acpi_pci_link_allocate+0x9b/0xf5
kernel:  [acpi_pci_link_get_irq+66/111] acpi_pci_link_get_irq+0x42/0x6f
kernel:  [acpi_pci_irq_lookup+63/97] acpi_pci_irq_lookup+0x3f/0x61
kernel:  [acpi_pci_irq_enable+131/342] acpi_pci_irq_enable+0x83/0x156
kernel:  [pcibios_enable_device+40/48] pcibios_enable_device+0x28/0x30
kernel:  [pci_enable_device_bars+43/64] pci_enable_device_bars+0x2b/0x40
kernel:  [pci_enable_device+34/80] pci_enable_device+0x22/0x50
kernel:  [pg0+543478421/1068790784] sil_init_one+0x25/0x310 [sata_sil]
kernel:  [pci_device_probe_static+82/112] pci_device_probe_static+0x52/0x70
kernel:  [__pci_device_probe+41/48] __pci_device_probe+0x29/0x30
kernel:  [pci_device_probe+44/80] pci_device_probe+0x2c/0x50
kernel:  [driver_probe_device+47/128] driver_probe_device+0x2f/0x80
kernel:  [driver_attach+89/144] driver_attach+0x59/0x90
kernel:  [bus_add_driver+152/208] bus_add_driver+0x98/0xd0
kernel:  [driver_register+47/64] driver_register+0x2f/0x40
kernel:  [pci_register_driver+64/80] pci_register_driver+0x40/0x50
kernel:  [pg0+543490063/1068790784] sil_init+0xf/0x13 [sata_sil]
kernel:  [sys_init_module+356/528] sys_init_module+0x164/0x210
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: handlers:
kernel: [usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
kernel: Disabling IRQ #11
kernel: ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
kernel: ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 11 (level, low) -> IRQ 11
kernel: ata1: SATA max UDMA/100 cmd 0xE0B02080 ctl 0xE0B0208A bmdma 0xE0B02000 irq 11
kernel: ata2: SATA max UDMA/100 cmd 0xE0B020C0 ctl 0xE0B020CA bmdma 0xE0B02008 irq 11
kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:20ff
kernel: ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48

--- END OUTPUT ---

   * When booting from the sata disk with sata_sil compiled into the kernel and no other 
  
     disks installed, the kernel first boots at normal speed and then hangs after giving 

     a very similar message, which also contains the lines "irq 11: nobody cared!", 

     "handlers:" and "Disabling IRQ #11". 
     
     

Conditions:

 Problem occurs *only*
  
    * if SATA-Controller is enabled 

    * after restarting from WindowsXP (whether APIC is enabled or not in the BIOS). 
       
  
 Warm and cold restarts do not change anything. 
 
    * Problem dissapears after powering off/on.


(In short: It is not possible for me to restart from Windows, which is annoying and 
causes a higher hardware wastage ;) 
  
--- END PROBLEM DESCRIPTION ---

 It seems like the (SATA-)BIOS simply forgets to reset something important. 
 
 (What could this be??)
 
 
 The boot loader slowdown could perhaps be caused by a very high interrupt 
 
 frequency as described in www.uwsg.iu.edu/hypermail/linux/kernel/0404.0/0455.html.
 
 
 
 I hope that someone who perhaps knows the source of sata_sil and has a concrete idea 
 
 of how things (with interrupts;) work can quickly analyse this from the output above,
 
 give me some hints or at least decide if this could be considered a BIOS bug.
 
 
 
 Thank you for reading.
 
 
 PS: I am not on the list. Please CC me. 
 


--- INTERRUPTS IN NORMAL OPERATION ---

           CPU0
  0:     783160          XT-PIC  timer
  1:       3076          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:        179          XT-PIC  ehci_hcd, ohci_hcd, eth0
  7:          0          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:         15          XT-PIC  ohci_hcd, libata
 12:         70          XT-PIC  i8042
 14:       1278          XT-PIC  ide0
 15:         23          XT-PIC  ide1
NMI:          0
ERR:          0

--- INTERRUPTS IN AFTER REBOOT FROM WINDOWS ---

           CPU0
  0:     792248          XT-PIC  timer
  1:       2542          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:        179          XT-PIC  ehci_hcd, ohci_hcd, eth0
  7:          0          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:     100000          XT-PIC  ohci_hcd, libata
 12:        198          XT-PIC  i8042
 14:       1155          XT-PIC  ide0
 15:         23          XT-PIC  ide1
NMI:          0
ERR:          0

--- HARDWARE ---

A7N8X DELUXE REV 2.0 (Silicon Image 3112 A controller)
LATEST BIOS INSTALLED: 1008 (SATA: 4.2.47)


--- LESS IMPORTANT THINGS ---

In normal operation under LINUX the HD-LED is ON continuously ;). 
