From: Jan Wagner <jwagner@kurp.hut.fi>
Subject: ich10r ahci with port multiplier or native detaches disks
Date: Mon, 8 Sep 2008 17:33:45 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.0809081638330.31178@kurp.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-2.hut.fi ([130.233.228.92]:46821 "EHLO smtp-2.hut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbYIHPjL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 11:39:11 -0400
Received: from localhost (katosiko.hut.fi [130.233.228.115])
	by smtp-2.hut.fi (8.13.6/8.12.10) with ESMTP id m88Eapgw031481
	for <linux-ide@vger.kernel.org>; Mon, 8 Sep 2008 17:36:51 +0300
Received: from smtp-2.hut.fi ([130.233.228.92])
 by localhost (katosiko.hut.fi [130.233.228.115]) (amavisd-new, port 10024)
 with LMTP id 18235-164-13 for <linux-ide@vger.kernel.org>;
 Mon,  8 Sep 2008 17:36:51 +0300 (EEST)
Received: from going-postal.kurp.hut.fi (quadrant.hut.fi [130.233.157.233])
	by smtp-2.hut.fi (8.13.6/8.12.10) with ESMTP id m88EXjpi029943
	for <linux-ide@vger.kernel.org>; Mon, 8 Sep 2008 17:33:45 +0300
Received: from kurp.hut.fi (kurp.hut.fi [130.233.244.1])
	by going-postal.kurp.hut.fi (Postfix) with ESMTP id BE7C03CAB2
	for <linux-ide@vger.kernel.org>; Mon,  8 Sep 2008 17:33:45 +0300 (EEST)
Received: from jwagner (helo=localhost)
	by kurp.hut.fi with local-esmtp (Exim 4.50)
	id 1KchoH-0008IT-Ll
	for linux-ide@vger.kernel.org; Mon, 08 Sep 2008 17:33:45 +0300
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

two problems with ICH10R in AHCI.

First the minor(?) issue, the ICH10(R) datasheet
   http://www.intel.com/Assets/PDF/datasheet/319973.pdf
says on page 527, PMS flag: port multipliers are not supported. The PMFSE 
flag page 542 says neither port multipliers nor FIS pmp are supported.

On our ASUS P5Q Pro motherboard with ICH10R, ahci detects 'pmp':

ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems

In light of the datasheet, perhaps in ahci.c the CAP register (read-only 
from host) 'pmp' flag should be actively reset to 0 for ich10r?


Ayway the bigger issue with ICH10R is that the SATA disks detach randomly 
during "heavy" i/o load. This happens withing just a few seconds. If I 
disable NCQ (echo 1 > nr_requests), it takes "longer" to happen, some ten 
seconds. I already ruled out the SATA cables, disks themselves, and disk 
cages as a cause.

The detaching happens at least in these (Ubuntu-patched) kernels:

$ uname -rm
2.6.27-2-generic i686

$ uname -rm
2.6.24-19-generic i686

It happens with disks behind a port multiplier. The ich10r 'pmp' 
"support" seems to work as CB- but not FIS-based, so it is slow, or just 
broken.

But the detaches also happen with disks connected to the native ich10r 
ports.

All in all ich10r seems to work very unreliably. So I was wondering if 
support for ICH10R in ahci.c is not complete yet?


Or can someone here shout "ich10r ahci works for me"?


The following happened with two disks behind a port multiplier and 
writing to one disk:

[10648.936095] sd 0:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[10648.936104] sd 0:0:0:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
[10648.936112] Descriptor sense data with sense descriptors (in hex):
[10648.936117]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[10648.936127]         00 00 00 00
[10648.936131] sd 0:0:0:0: [sdb] Add. Sense: No additional sense information
[10648.936152] ata1: EH complete
[10648.936200] sd 0:1:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
[10648.936221] sd 0:1:0:0: [sdc] Write Protect is off
[10648.936270] sd 0:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[10648.936278] ata1.00: detaching (SCSI 0:0:0:0)
[10648.936289] Dev sdb: unable to read RDB block 0
[10648.936322]  unable to read partition table
[10648.938056] sd 0:0:0:0: [sdb] Synchronizing SCSI cache
[10648.938099] sd 0:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[10648.938103] sd 0:0:0:0: [sdb] Stopping disk
[10648.938114] sd 0:0:0:0: [sdb] START_STOP FAILED

And this happened with the port multiplier removed and different disks 
connected to only the native ich10r ports with no multiplier:

[470.408042] sd 1:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[470.408047] sd 1:0:0:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
[470.408055] Descriptor sense data with sense descriptors (in hex):
[470.408057]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[470.408068]         00 01 34 00
[470.408072] sd 1:0:0:0: [sdb] Add. Sense: No additional sense information
[470.408208] lost page write due to I/O error on md0
[470.408268] lost page write due to I/O error on md0
[470.408326] lost page write due to I/O error on md0
...
[470.408836] sd 1:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[470.408839] sd 1:0:0:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
[470.408845] Descriptor sense data with sense descriptors (in hex):
[470.408847]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[470.408858]         00 01 34 00
[470.408861] sd 1:0:0:0: [sdb] Add. Sense: No additional sense information
[470.409021] sd 1:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[470.409025] sd 1:0:0:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
[470.409030] Descriptor sense data with sense descriptors (in hex):
[470.409032]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[470.409042]         00 01 34 00
[470.409046] sd 1:0:0:0: [sdb] Add. Sense: No additional sense information

For me kind of hard to debug. If you need more info please just say!

Many thanks,
  - Jan
