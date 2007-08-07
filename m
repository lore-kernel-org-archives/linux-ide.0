From: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Subject: [PATCH 0/1] AVR32 PATA driver
Date: Tue, 7 Aug 2007 11:26:08 +0200
Message-ID: <200708071126.08735.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:61764 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755174AbXHGJ1t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 05:27:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kngregertsen@norway.atmel.com, gregerts@stud.ntnu.no

Hi everybody,

My PATA driver for AVR32 is now working in all PIO modes. I have
tested the driver for two weeks and it seems pretty stable, there
are no file corruption or fatal errors.

This is a typical result by running Bonnie in PIO4 (file size 104857600):

-------Sequential Output-------- ---Sequential Input-- --Random--
-Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
 MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
100  1599 80.5  5305 20.4  2581 17.4  1385 78.0  5068 14.8  45.8  1.9                               

Yet there are still some issues:

1) In PIO1 and PIO2 there are rare freezes:

ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd 20/00:00:d3:7e:5d/00:00:00:00:00/e1 tag 0 cdb 0x0 data 131072 in
         res 58/00:01:d2:7f:5d/00:00:01:00:00/e1 Emask 0x2 (HSM violation)

The freezes happen close to each other in time. The freezes does not make file
operations fail.

2) After being in operation for a long time (+24 hours) the disk reports wrong
identity:

ata4.00: model number mismatch 'IC35L060AVV207-0' != ''
ata4.00: revalidation failed (errno=-19)
ata4.00: limiting speed to PIO2
ata4: failed to recover some devices, retrying in 5 secs
ata4.00: model number mismatch 'IC35L060AVV207-0' != 'AV07-0 *GARBEL*

This has happend with both the devices I am testing, the 'Quantum Fireball'
reported it self to be 'Quanpum Fiveball' after 24 hours of testing.

I also have a question regrding INTRQ / IRQ handeling. Since I am not using
DMA, there seems to be no reason to handle interrupts, so I set the polling
flag. Not using the polling flag gives a lot of interrupts that does not seem
to do anything except eating my CPU cycles. Is this correct?

If so, what shall I do when activating the host to not get "irq 65: nobody
cared" ... "Disabling IRQ #65". Should I give an negative irq number?

Any help and reviews of my code would be appriciate :)
-- 
Kristoffer Nyborg Gregertsen
MSc. student / Summer intern
Atmel Norway
