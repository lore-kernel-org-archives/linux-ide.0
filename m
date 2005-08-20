From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:upstream 00/02] libata: race fixes
Date: Sat, 20 Aug 2005 23:15:29 +0900 (KST)
Message-ID: <20050820141408.62050C34@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:39511 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751092AbVHTOPi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 10:15:38 -0400
Received: by wproxy.gmail.com with SMTP id i2so779760wra
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2005 07:15:35 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com
Cc: linux-ide@vger.kernel.org

 Hello, Jeff & Albert.

 This is another patchset fixing races in libata.

 The first patch implements ata_poll_qc_complete which graps host
lock, turns irq back on, completes qc and release host lock.  All
command completion in polling tasks are replaced with this function.
The effect is...

 * If an interrupt from other ports or a spurious interrupt occurs
   inbetween ata_irq_on and ata_qc_complete, it leads to double
   completion of the qc.  This race is fixed.

 * atapi_packet_task() now reenables IRQ on error exit.

 * ata_qc_complete() is now always called with host lock.

 The second patch adds locking to ata_scsi_error such that
->eng_timeout is called after ata_qc_complete is complete.
Previously, EH and the latter part of ata_qc_complete could run side
by side.

 Albert, I think, this patch should kill the race you tried to fix by
moving ATA_QCFLAG_ACTIVE clearing above ->complete_fn invocation.

[ Start of patch descriptions ]

01_libata_add-ata_poll_qc_complete.patch
	: implement ata_poll_qc_complete and use it in polling functions

	Previously, libata polling functions turned irq back on and
	completed qc commands without holding host lock.  This creates
	a race condition between the polling task and interrupts from
	other ports on the same host set or spurious interrupt from
	itself.

	This patch implements ata_poll_qc_complete which enables irq
	and completes qc atomically and convert all polling functions.

	Note: Unlike other functions, atapi_packet_task() didn't use
	to turn irq back on on error exits.  This patch makes it use
	ata_poll_qc_complete, so irq is now turned back on on error
	exits.

	Note: With this change, ALL invocations of ata_qc_complete()
	are now done under host_set lock.

02_libata_add-locking-to-ata_scsi_error.patch
	: add host_set locking to ata_scsi_error()

	SCSI EH can start before ata_qc_complete is completely
	complete.  so, latter part of ata_qc_complete can run
	side-by-side with ->eng_timeout(), interfering EH.

        This patch makes ata_scsi_error() to grab and release host_set
	lock before invoking ->eng_timeout().

	Note: host_failed decrementing and eh_cmd_q banging are moved
	above ->eng_timeout() invocation such that they're done while
	holding the lock.

[ End of patch descriptions ]

 Thanks.

--
tejun

