From: Mark Lord <liml@rtr.ca>
Subject: libata-eh not reporting failed LBA correctly?
Date: Wed, 23 Apr 2008 16:02:52 -0400
Message-ID: <480F95EC.6090303@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4917 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002AbYDWUCw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 16:02:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun,

I'm now working on (libata-dev#upstream) getting sata_mv to give detailed
error information when a drive reports (for example) a media error.

If I stop sata_mv from freezing the port right away, then libata-eh
correctly runs and issues the READ_LOG_EXT_10H to the drive,
and gets back the correct NCQ error info.  So far, so good:

    ata31: qc_issue: command=0x60
    ata31: mv_err_intr: qc=00000000 err_mask=00000001 err_cause=00000084 freeze_mask=fc1e9ebb freezing port
    ata31: qc_issue: command=0x2f
    ata31.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
    ata31.00: edma_err_cause=00000084, EDMA self-disable
    ata31.00: cmd 60/10:00:08:27:00/00:00:00:00:00/40 tag 0 ncq 8192 in
             res 51/40:10:10:27:00/e3:00:00:00:00/00 Emask 0x409 (media error) <F>
    ata31.00: status: { DRDY ERR }
    ata31.00: error: { UNC }

So there, we see that the drive reported failure on LBA 0x002710 =
sector number 10000 (base10).
This is correct: I corrupted that sector on purpose for the test.

But.. then something peculiar happens:

    ata31: qc_issue: command=0xec
    ata31: qc_issue: command=0x27
    ata31: qc_issue: command=0xef
    ata31: qc_issue: command=0xec
    ata31: qc_issue: command=0x27
    ata31.00: configured for UDMA/133
    sd 30:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
    sd 30:0:0:0: [sdb] Sense Key : Medium Error [current] [descriptor]
    Descriptor sense data with sense descriptors (in hex):
            72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00 
            00 00 00 10 
    sd 30:0:0:0: [sdb] Add. Sense: Unrecovered read error - auto reallocate failed
    end_request: I/O error, dev sdb, sector 9992
    ...

According to SCSI, we either did not report a valid sector number,
or we reported sector 9992 as having the problem.  That's not right.

I wonder where we lost that information ?
Looking through libata-eh, I don't see any place that explicitly
sets the result tf.flags field anywhere, other than copying them
from the outgoing READ_LOG_EXT taskfile.  Perhaps that's the problem ?

I'll dig some more, but clues would be handy.

Cheers

