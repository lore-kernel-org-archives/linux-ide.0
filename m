From: Tim Small <tim@seoss.co.uk>
Subject: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI controller
Date: Tue, 07 Jun 2011 19:04:33 +0100
Message-ID: <4DEE6831.9020501@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay0.allsecurenet.com ([109.169.27.60]:43137 "EHLO
	relay0.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923Ab1FGS7z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Jun 2011 14:59:55 -0400
Received: from [78.105.152.189] (helo=zebedee.buttersideup.com)
	by relay0.allsecurenet.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <tim@seoss.co.uk>)
	id 1QU0dl-0003RT-Tn
	for linux-ide@vger.kernel.org; Tue, 07 Jun 2011 19:04:34 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zebedee.buttersideup.com (Postfix) with ESMTP id 69AF8410CB
	for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2011 19:04:33 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi,

I'm putting together a storage box to be used as a backup server with a
few disks (probably 26 hard disks - 3.5" 2TB 5900rpm), and have been
trying out a Silicon Image 3726 port multiplier.

The box I'm building currently has SATA ports provided by four different
types of controllers:

SATA 3 and 4x SATA 2 (Intel H67 chipset ports in ahci mode).
SATA 2 (Silicon Image 3132 - a single PCIe 1.0 x1 add-in card - ideally
only for temporary debugging reasons).
SATA 3 (Marvell 88SE9123 - several PCI express 2.0 x1 AHCI controller
cards).
SATA 2 (Silicon Image 3124 - PCI card).


The H67 seems to support the port multiplier but only in CBS mode (I can
read from an Intel 80G SSD at 260M per second when connected directly to
the motherboard, 170M per second from the motherboard AHCI via the PMP,
but that speed drops to 20M per second when I concurrently read from a
hard drive attached to the same port multiplier).

The Silicon Image 3132 works with the port multiplier, but I can only
get about 130M per second out of the 3132 (PCIe 1.0 1x with MaxPayload
128 bytes is all I get on this Gigabyte GA-PH67A-UD3-B3 motherboard), it
seems to be using FIS mode (the 130M per second is shared between drives
during concurrent reads).

The Silicon Image 3124 also works, but is not much use because the
ITE8892 PCI bridge chip only supports ye olde 33MHz PCI (so ~80M per
second max throughput for the whole card).

If I connect the 3726 port multiplier to the Marvell 88SE9123, it gets
recognised, and various ports get reset, but a "Port Multiplier vendor
mismatch" error message gets printed out, and no actual drives get detected.

77.203802] ata14: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
77.204043] ata14: irq_stat 0x80400040, connection status changed
77.204201] ata14: SError: { PHYRdyChg CommWake DevExch }
77.204360] ata14: hard resetting link
78.098504] ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
78.098905] ata14.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
78.100545] ahci 0000:01:00.0: FBS is enabled.
78.100792] ata14.00: hard resetting link
78.418603] ata14.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
78.418795] ata14.01: hard resetting link
78.738493] ata14.01: SATA link down (SStatus 0 SControl 320)
78.738695] ata14.02: hard resetting link
79.058397] ata14.02: SATA link down (SStatus 0 SControl 320)
79.058595] ata14.03: hard resetting link
79.378274] ata14.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
79.378454] ata14.04: hard resetting link
79.698187] ata14.04: SATA link down (SStatus 0 SControl 320)
79.698382] ata14.05: hard resetting link
83.016906] ata14.15: qc timeout (cmd 0xe4)
83.017069] ata14.05: failed to read SCR 0 (Emask=0x4)
83.017226] ata14.05: failed to read SCR 0 (Emask=0x40)
83.017385] ata14.05: failed to read SCR 0 (Emask=0x40)
83.017540] ata14.00: failed to IDENTIFY (I/O error, err_mask=0x40)
83.017706] ata14.15: hard resetting link
83.788616] ata14.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
83.788966] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x113'
83.789149] ata14.15: PMP revalidation failed (errno=-19)
88.786995] ata14.15: hard resetting link
89.558702] ata14.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
89.559059] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x113'
89.559225] ata14.15: PMP revalidation failed (errno=-19)
89.559383] ata14.15: limiting SATA link speed to 1.5 Gbps
94.557103] ata14.15: hard resetting link
95.328790] ata14.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
95.329185] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x113'
95.329357] ata14.15: PMP revalidation failed (errno=-19)
95.329517] ata14.15: failed to recover PMP after 5 tries, giving up
95.329682] ata14.15: Port Multiplier detaching
95.329838] ata14.00: disabled
95.329981] ata14: EH complete



I found this:

https://gist.github.com/709632

"Using Marvell 88SE9123 Chip with Sil3726 PMP Chip Workaround patch for gentoo-sources-2.6.36-r1"


--- libata-pmp.c.orig 2010-11-22 04:34:38.000000000 +0900
+++ libata-pmp.c 2010-11-22 04:42:59.000000000 +0900
@@ -286,6 +286,8 @@
                        reason = "failed to write Sil3726 Private Register";
                        goto fail;
                }
+ /* nr_ports decrement */
+ nr_ports--;
        }
 
        if (print_info) {



... and was going to give it a go, but it's not really obvious to me
what it does (aside from the err great comment of course), and I
couldn't find any other references to this patch on the web, and thought
someone here might be able to shed some light on it...

Cheers,

Tim.
