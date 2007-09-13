From: Mark Lord <liml@rtr.ca>
Subject: Re: ATAPI tape drives broken with libata
Date: Thu, 13 Sep 2007 14:22:32 -0400
Message-ID: <46E97FE8.5090304@rtr.ca>
References: <46D5F97B.3050808@redhat.com>	<20070830005006.6951265a@the-village.bc.nu>	<46D6EC3B.8090306@redhat.com> <20070831151903.37a60ba9@the-village.bc.nu> <46E966C2.1050405@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3398 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754309AbXIMSWz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Sep 2007 14:22:55 -0400
In-Reply-To: <46E966C2.1050405@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, craig48@swbell.net

I added code in libata-core.c at ata_qc_issue & ata_qc_issue_prot
which dumps qc->cdb if protocol is ATAPI:

14:10:48 root: writing to the tape next
14:11:01 kernel: qc_issue:      CDB 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:11:01 kernel: qc_issue_prot: CDB 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
14:11:01 kernel: qc_issue:      CDB 03 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
14:11:01 kernel: qc_issue_prot: CDB 03 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
14:11:01 kernel: ata3: DRQ=1 with device error, dev_stat 0x59
14:11:01 kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
14:11:01 kernel: ata3.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
14:11:01 kernel:          res 51/60:03:00:00:20/00:00:00:00:00/a0 Emask 0x3 (HSM violation)
14:11:01 kernel: ata3: soft resetting port
14:11:02 kernel: ata3.00: revalidation failed (errno=-2)
14:11:02 kernel: ata3: failed to recover some devices, retrying in 5 secs
14:11:07 kernel: ata3: soft resetting port
14:11:08 kernel: spurious 8259A interrupt: IRQ7.
14:11:09 kernel: ata3.01: failed to IDENTIFY (I/O error, err_mask=0x1)
14:11:09 kernel: ata3: failed to recover some devices, retrying in 5 secs
14:11:14 kernel: ata3: soft resetting port
14:11:15 kernel: ata3.01: failed to IDENTIFY (I/O error, err_mask=0x1)
14:11:15 kernel: ata3.01: limiting speed to UDMA7:PIO4
14:11:15 kernel: ata3: failed to recover some devices, retrying in 5 secs
14:11:20 kernel: ata3: soft resetting port
14:11:20 kernel: ata3.01: failed to IDENTIFY (I/O error, err_mask=0x1)
14:11:20 kernel: ata3: failed to recover some devices, retrying in 5 secs
14:11:25 kernel: ata3: soft resetting port
14:11:26 kernel: ata3.00: configured for PIO2
14:11:26 kernel: ata3: EH pending after completion, repeating EH (cnt=4)
14:11:26 kernel: ata3: EH complete
