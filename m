From: Erwan MAS <erwan@mas.nom.fr>
Subject: Sr2760-2s-s2 & Sil4723 & pmp
Date: Mon, 7 Dec 2009 12:44:17 +0100
Message-ID: <20091207114417.GB1863@voyageur.mas.nom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pulsar.zoreil.com ([83.167.33.49]:39081 "EHLO pulsar.zoreil.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934215AbZLGLwK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Dec 2009 06:52:10 -0500
Received: from pulsar.zoreil.com (IDENT:zhF6bC9KmAKPKNKlO75aCarJSeHg2KIq@localhost [127.0.0.1])
	by pulsar.zoreil.com (8.12.10/8.12.10) with ESMTP id nB7Bik6p007552
	for <linux-ide@vger.kernel.org>; Mon, 7 Dec 2009 12:44:46 +0100
Received: (from uucp@localhost)
	by pulsar.zoreil.com (8.12.10/8.12.10) id nB7BikqR007550
	for linux-ide@vger.kernel.org; Mon, 7 Dec 2009 12:44:46 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello ,

I tried to use sr2760-2s-s2 ( http://www.raidon.com.tw/content.php?sno=0000095&p_id=53 ) with linux !

With
  kernel 2.6.21           => work 
  kernel 2.6.26 & 2.6.28  => does not work 

In 2.26.21 , the device is detect as sata disk , i can access to it !

In 2.26.26 & 2.6.28 , the sata port multiplier detect the sil4723 chipset and try to use in a port multiplier mode 
( i suppose ) .

Extract of /var/log/messages

Dec  6 14:13:56 charlie kernel: [    6.765363] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Dec  6 14:13:56 charlie kernel: [    6.768941] ata4.15: Port Multiplier 1.1, 0x1095:0x4723 r28, 3 ports, feat 0x1/0x9
Dec  6 14:13:56 charlie kernel: [    6.768941] ata4.00: hard resetting link
Dec  6 14:13:56 charlie kernel: [    7.125525] ata4.00: SATA link down (SStatus 0 SControl 0)
Dec  6 14:13:56 charlie kernel: [    7.125525] ata4.01: hard resetting link
Dec  6 14:13:56 charlie kernel: [    7.668637] ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Dec  6 14:13:56 charlie kernel: [    7.668637] ata4.02: hard resetting link
Dec  6 14:13:56 charlie kernel: [    8.036177] ata4.02: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Dec  6 14:13:56 charlie kernel: [    8.036177] ata4.01: unsupported device, disabling
Dec  6 14:13:56 charlie kernel: [    8.036177] ata4.01: disabled
Dec  6 14:13:56 charlie kernel: [    8.042941] ata4: EH complete

My systems as asus M3A motherboard . 

a part of output from lspci -v :

00:12.0 SATA controller: ATI Technologies Inc SB600 Non-Raid-5 SATA (prog-if 01 [AHCI 1.0])
	Subsystem: ASUSTeK Computer Inc. Device 8231
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 22
	I/O ports at c000 [size=8]
	I/O ports at b000 [size=4]
	I/O ports at a000 [size=8]
	I/O ports at 9000 [size=4]
	I/O ports at 8000 [size=16]
	Memory at f9fff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 2
	Kernel driver in use: ahci
	Kernel modules: ahci

-- 
     ____________________________________________________________
    / Erwan MAS                                                 /\
   | mailto:erwan@mas.nom.fr                                   |_/
___|________________________________________________________   |
\___________________________________________________________\__/
