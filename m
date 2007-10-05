From: gilberto@sistemafenix.com.br
Subject: Sata VIA New ID
Date: Fri, 5 Oct 2007 18:48:38 -0300 (BRT)
Message-ID: <63379.201.21.145.69.1191620918.squirrel@webmail.sistemafenix.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from spamproxy.conntrust.com ([200.162.222.11]:35026 "EHLO
	srv001.conntrust.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751421AbXJEVzW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Oct 2007 17:55:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi, my name is Gilberto I am from of the distribuition linux call FeniX
Linux in Brazil.
I need your help, I need put in sata_via.c a new ID for hd sata in my
kernel 2.6.20.7
I need only put the new id or I need make more things

The Gigabyte from Brasil, put for sale a new model call GA-VM900M with
sata 2, In new kernel 2.6.22-9 its working. But I have some drivers
compiled for my kernel its impossible change the version of the kernel,
only because new SATA2

And some manufetures of Desktops are with problems because this.


static const struct pci_device_id svia_pci_tbl[] = {
	{ PCI_VDEVICE(VIA, 0x5337), vt6420 },
	{ PCI_VDEVICE(VIA, 0x0591), vt6420 },
	{ PCI_VDEVICE(VIA, 0x3149), vt6420 },
	{ PCI_VDEVICE(VIA, 0x3249), vt6421 },
	{ PCI_VDEVICE(VIA, 0x5372), vt6420 },    ***** I put this line only ****


	{ }	/* terminate list */
};

What do I need for resolve this problem....

my lspci is
root@fenix:/usr/src/linux-2.6.22.9/drivers/ata# lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
0000:00:00.1 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
0000:00:00.2 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
0000:00:00.3 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
0000:00:00.4 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
0000:00:00.5 PIC: VIA Technologies, Inc. P4M900 I/O APIC Interrupt Controller
0000:00:00.6 Host bridge: VIA Technologies, Inc. P4M900 Security Device
0000:00:00.7 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:02.0 PCI bridge: VIA Technologies, Inc. P4M900 PCI to PCI Bridge
Controller (rev 80)
0000:00:03.0 PCI bridge: VIA Technologies, Inc. P4M900 PCI to PCI Bridge
Controller (rev 80)
0000:00:0f.0 IDE interface: VIA Technologies, Inc.: Unknown device 5372
0000:00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 07)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev b0)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev b0)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev b0)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev b0)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 90)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237S PCI to ISA Bridge
0000:00:11.7 Host bridge: VIA Technologies, Inc. VT8251 Ultra VLINK
Controller
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 7c)
0000:00:13.0 Host bridge: VIA Technologies, Inc. VT8237A Host Bridge
0000:00:13.1 PCI bridge: VIA Technologies, Inc. VT8237A PCI to PCI Bridge
0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. Chrome9 HC
IGP (rev 01)
0000:80:01.0 Audio device: VIA Technologies, Inc. VIA High Definition
Audio Controller (rev 10)
root@fenix:/usr/src/linux-2.6.22.9/drivers/ata#

the lspci -n is:

root@fenix:/usr/src/linux-2.6.22.9/drivers/ata# lspci -n
0000:00:00.0 0600: 1106:0364
0000:00:00.1 0600: 1106:1364
0000:00:00.2 0600: 1106:2364
0000:00:00.3 0600: 1106:3364
0000:00:00.4 0600: 1106:4364
0000:00:00.5 0800: 1106:5364
0000:00:00.6 0600: 1106:6364
0000:00:00.7 0600: 1106:7364
0000:00:01.0 0604: 1106:b198
0000:00:02.0 0604: 1106:a364 (rev 80)
0000:00:03.0 0604: 1106:c364 (rev 80)

0000:00:0f.0 0101: 1106:5372
0000:00:0f.1 0101: 1106:0571 (rev 07)

0000:00:10.0 0c03: 1106:3038 (rev b0)
0000:00:10.1 0c03: 1106:3038 (rev b0)
0000:00:10.2 0c03: 1106:3038 (rev b0)
0000:00:10.3 0c03: 1106:3038 (rev b0)
0000:00:10.4 0c03: 1106:3104 (rev 90)
0000:00:11.0 0601: 1106:3372
0000:00:11.7 0600: 1106:287e
0000:00:12.0 0200: 1106:3065 (rev 7c)
0000:00:13.0 0600: 1106:337b
0000:00:13.1 0604: 1106:337a
0000:01:00.0 0300: 1106:3371 (rev 01)
0000:80:01.0 0403: 1106:3288 (rev 10)

PLEASE HELP ME!

0000:00:0f.0 0101: 1106:5372
0000:00:0f.1 0101: 1106:0571 (rev 07)
I believe the IDS are above.

Gilberto
FeniX Linux
www.sistemafenix.com.br





