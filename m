From: Mark Lord <liml@rtr.ca>
Subject: Re: ATAPI tape drives broken with libata
Date: Thu, 13 Sep 2007 14:42:22 -0400
Message-ID: <46E9848E.2000704@rtr.ca>
References: <46D5F97B.3050808@redhat.com>	<20070830005006.6951265a@the-village.bc.nu>	<46D6EC3B.8090306@redhat.com> <20070831151903.37a60ba9@the-village.bc.nu> <46E966C2.1050405@rtr.ca> <46E97FE8.5090304@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2062 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470AbXIMSmY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Sep 2007 14:42:24 -0400
In-Reply-To: <46E97FE8.5090304@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, craig48@swbell.net

> 14:10:48 root: writing to the tape next
> 14:11:01 kernel: qc_issue:      CDB 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 14:11:01 kernel: qc_issue_prot: CDB 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 14:11:01 kernel: qc_issue:      CDB 03 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
> 14:11:01 kernel: qc_issue_prot: CDB 03 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
> 14:11:01 kernel: ata3: DRQ=1 with device error, dev_stat 0x59
> 14:11:01 kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> 14:11:01 kernel: ata3.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
> 14:11:01 kernel:          res 51/60:03:00:00:20/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
> 14:11:01 kernel: ata3: soft resetting port
...

Okay, if I simply change the code to ignore the test
for "DRQ=1 with device error", things appear to work.

14:26:48 root: writing
14:26:54 kernel: qc_issue: CDB 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:26:54 kernel: qc_issue_prot: CDB 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:26:54 kernel: qc_issue: CDB 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:26:54 kernel: qc_issue_prot: CDB 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:26:54 kernel: qc_issue: CDB 03 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
14:26:54 kernel: qc_issue_prot: CDB 03 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
14:26:54 kernel: ata3: DRQ=1 with device error, dev_stat 0x59
14:26:54 kernel: st0: Sense Key : Illegal Request [current]
14:26:54 kernel: st0: Add. Sense: Invalid command operation code
14:26:54 kernel: qc_issue: CDB 1a 00 00 00 0c 00 00 00 00 00 00 00 00 00 00 00
14:26:54 kernel: qc_issue_prot: CDB 1a 00 00 00 0c 00 00 00 00 00 00 00 00 00 00 00
14:26:54 kernel: qc_issue: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:26:54 kernel: qc_issue_prot: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue_prot: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue_prot: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue_prot: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue_prot: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue_prot: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00
14:27:01 kernel: qc_issue_prot: CDB 0a 01 00 00 08 00 00 00 00 00 00 00 00 00 00 00

I can read and write the tape successfully, and the written data matches
what is later read back from it.

Here's the hack I used.  Not ready for mainline, but perhaps it will
help Alan or whomever come up with something nice for Jeff.

--- 2.6.23-rc6/drivers/ata/libata-core.c  2007-09-13 09:49:16.000000000 -0400
+++ linux/drivers/ata/libata-core.c     2007-09-13 14:15:57.000000000 -0400
@@ -4932,9 +4932,9 @@
                if (unlikely(status & (ATA_ERR | ATA_DF))) {
                        ata_port_printk(ap, KERN_WARNING, "DRQ=1 with device "
                                        "error, dev_stat 0x%X\n", status);
-                       qc->err_mask |= AC_ERR_HSM;
-                       ap->hsm_task_state = HSM_ST_ERR;
-                       goto fsm_start;
+                       //qc->err_mask |= AC_ERR_HSM;
+                       //ap->hsm_task_state = HSM_ST_ERR;
+                       //goto fsm_start;
                }

                /* Send the CDB (atapi) or the first data block (ata pio out).

