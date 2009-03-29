From: kenneth johansson <ken@kenjo.org>
Subject: lost external eSATA port
Date: Sun, 29 Mar 2009 12:28:51 +0000 (UTC)
Message-ID: <gqnpi3$jq2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:56629 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbZC2M3J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Mar 2009 08:29:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lnu8O-0005TF-Hu
	for linux-ide@vger.kernel.org; Sun, 29 Mar 2009 12:29:04 +0000
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 29 Mar 2009 12:29:04 +0000
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 29 Mar 2009 12:29:04 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

After an error on the external disk the port no longer work with any disk.
When the error happened the /dev/sdx was removed. if I change disk its never recreated.
I get no log output from kernel indicating any type of action at all.

Is there a way to reset the port ?? 

--------------

I have a
Base Board Information
	Manufacturer: ASUSTeK Computer INC.
	Product Name: P5B-V
	Version: Rev 1.xx

board where  I think the eSATA port is controlled by 
IDE interface: Intel Corporation 82801H (ICH8 Family) 4 port SATA IDE Controller (rev 02)
or perhaps 
SATA controller: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller (rev 02)
----------
kernel is 2.6.28.7
----------
this is the last kernel log regarding the esata port. 

[ 2082.771431] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 2082.771440] ata3.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2082.771442]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
[ 2082.771443]          res 51/04:00:00:71:00/00:00:00:00:00/00 Emask 0x1 (device error)
[ 2082.771446] ata3.00: status: { DRDY ERR }
[ 2082.771613] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 2082.771615] ata3.00: ST_FIRST: !(DRQ|ERR|DF)
[ 2082.771621] ata3.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 2082.771622]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
[ 2082.771623]          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
[ 2082.771643] ata3: soft resetting link
[ 2082.940837] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x2)
[ 2082.940840] ata3.00: revalidation failed (errno=-5)
[ 2092.944030] ata3: link is slow to respond, please be patient (ready=0)
[ 2097.964030] ata3: device not ready (errno=-16), forcing hardreset
[ 2097.964041] ata3: soft resetting link
[ 2098.128113] ata3.01: NODEV after polling detection
[ 2098.128273] ata1.00: exception Emask 0x60 SAct 0x0 SErr 0x800 action 0x6 frozen
[ 2098.128276] ata1.00: irq_stat 0x20000000, host bus error
[ 2098.128278] ata1: SError: { HostInt }
[ 2098.128282] ata1.00: cmd 35/00:00:00:0c:32/00:04:06:00:00/e0 tag 0 dma 524288 out
[ 2098.128283]          res 50/00:00:ff:0b:32/00:00:06:00:00/e0 Emask 0x60 (host bus error)
[ 2098.128285] ata1.00: status: { DRDY }
[ 2098.128288] ata1: hard resetting link
[ 2098.136193] ata3.00: NODEV after polling detection
[ 2098.136196] ata3.00: revalidation failed (errno=-2)
[ 2098.952047] ata1: SATA link down (SStatus 0 SControl 71)
[ 2103.120039] ata3: soft resetting link
[ 2103.284188] ata3.00: NODEV after polling detection
[ 2103.284192] ata3.00: revalidation failed (errno=-2)
[ 2103.284196] ata3.00: disabled
[ 2103.284229] ata3: soft resetting link
[ 2103.440115] ata3: EH complete
[ 2103.952028] ata1: hard resetting link
[ 2104.776050] ata1: SATA link down (SStatus 0 SControl 71)
[ 2104.776060] ata1: limiting SATA link speed to 1.5 Gbps
[ 2109.806610] ata1: hard resetting link
[ 2110.628041] ata1: SATA link down (SStatus 0 SControl 71)
[ 2110.628050] ata1.00: disabled
[ 2110.628069] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[ 2110.628074] sd 0:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[ 2110.628079] Descriptor sense data with sense descriptors (in hex):
[ 2110.628082]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
[ 2110.628092]         06 32 0b ff 
[ 2110.628096] sd 0:0:0:0: [sda] Add. Sense: No additional sense information
[ 2110.628101] end_request: I/O error, dev sda, sector 103943168
[ 2110.628118] ata1: EH complete
[ 2110.630096] ata1.00: detaching (SCSI 0:0:0:0)
[ 2110.634675] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 2110.634726] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 2110.634731] sd 0:0:0:0: [sda] Stopping disk
[ 2110.634742] sd 0:0:0:0: [sda] START_STOP FAILED
[ 2110.634744] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

