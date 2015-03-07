From: Fleck <Fleck@Rullz.lv>
Subject: eSata problem
Date: Sun, 08 Mar 2015 01:21:34 +0200
Message-ID: <54FB87FE.3050109@Rullz.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cccserv1.ccc.lv ([92.240.69.148]:42858 "EHLO cccserv1.ccc.lv"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbbCGXWa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Mar 2015 18:22:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, lkml@vger.kernel.org

  Hello, I have got the following eSata 4-bay device: 
http://www.mediasonic.ca/product.php?id=1357292050
Motherboard Asus M5A97 EVO R2.0 with eSata controler: 04:00.0 SATA 
controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 01)
As you can see, the 4-bay device needs Port Multiplier, in Windows 7 
everything works fine (just saying, hardware is OK), all 4 disk drives 
are detected, but in linux not a single drive is detected! Here is dmesg 
output after powering 4-bay device off and on again:

[ 1438.120315] ata11: exception Emask 0x10 SAct 0x0 SErr 0x10002 action 
0xe frozen
[ 1438.120323] ata11: irq_stat 0x00400000, PHY RDY changed
[ 1438.120329] ata11: SError: { RecovComm PHYRdyChg }
[ 1438.120340] ata11: hard resetting link
[ 1438.842876] ata11: SATA link down (SStatus 0 SControl 300)
[ 1438.842896] ata11: EH complete
[ 1449.670083] ata11: exception Emask 0x10 SAct 0x0 SErr 0x4040000 
action 0xe frozen
[ 1449.670091] ata11: irq_stat 0x00000040, connection status changed
[ 1449.670097] ata11: SError: { CommWake DevExch }
[ 1449.670107] ata11: hard resetting link
[ 1455.601866] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1460.599233] ata11.00: qc timeout (cmd 0xec)
[ 1460.599247] ata11.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 1460.599255] ata11: hard resetting link
[ 1461.090989] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1471.085591] ata11.00: qc timeout (cmd 0xec)
[ 1471.085605] ata11.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 1471.085636] ata11: limiting SATA link speed to 1.5 Gbps
[ 1471.085642] ata11: hard resetting link
[ 1471.577336] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1501.561182] ata11.00: qc timeout (cmd 0xec)
[ 1501.561196] ata11.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 1501.561204] ata11: hard resetting link
[ 1502.052960] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1502.052980] ata11: EH complete


Any ideas, how can I get this device working in linux?
BTW got this mail in #kernel channel @ freenode! :)


     Thanks, best regards - Fleck
