From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH Linux 2.6.12 00/09] NCQ: generic NCQ completion/error-handling
Date: Mon, 27 Jun 2005 00:21:07 +0900 (KST)
Message-ID: <20050626152105.D86561FB@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.194]:41494 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261305AbVFZPVO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:21:14 -0400
Received: by wproxy.gmail.com with SMTP id 58so199297wri
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:21:12 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

 Hello, Jeff.
 Hello, Jens.

 This patchset implements generic completion and error-handling for
NCQ commands.  This patchset assumes that the previous six misc
patches to NCQ are applied.

 In the original implementation, ahci driver proper handled completion
and error-handling of NCQ commands and NCQ error-handling was broken.

 * fails to finish scsi cmds (EH cannot be entered after the first
   time and erring requests never get completed or failed.)
 * doesn't reset host_failed
 * corrupts shost->eh_cmd_q

 New implementation...

 * does as much as possible in the libata-core layer.
 * unifies error and timeout paths and handles all in EH context.

 I tested EH using ASUS P5LD2 (ICH7R) and Samsung HD160JJ, and, for
me, EH is pretty solid now.  I'll post logs from my test runs in a
reply to this mail.

[ Start of patch descriptions ]

01_NCQ_add-ata_qc_complete_err.patch
	: add ata_qc_complete_err() and @drv_err to functions

	In the error path, the error register is read in the later
	stage during sense buffer construction.  However, w/ NCQ, we
	need to get the error register value from the log page and use
	it for sense buffer construction.  This patch adds
	ata_qc_complete_err() and adds @drv_err to functions in the
	error path.

02_NCQ_add-timeout-to-ata_read_log_page.patch
	: add timeout to ata_read_log_page()

	Some drives may lock up during read log page after NCQ
	failures (HD160JJ does), so we need to timeout
	ata_read_log_page().  This function adds timeout feature to
	ata_read_log_page().

03_NCQ_implement-ap_sactive.patch
	: add ap->sactive

	This patch makes libata-core layer aware of ap->sactive
	status.

04_NCQ_export-scsi_retry_command.patch
	: export scsi_retry_command

	Export scsi_retry_command

05_NCQ_add-ncq-helpers.patch
	: implement NCQ helpers

	This patch implements the following NCQ helpers to be used by
	specific drivers to implement interrupt and error handler.

	ata_ncq_complete()	: normal completion of commands
	ata_ncq_abort()		: error completion of commands
	ata_ncq_recover()	: EH recovery helper

06_NCQ_ahci-new-eh.patch
	: convert ahci to use new NCQ helpers

	This patch converts ahci to use new NCQ helpers.

07_NCQ_ahci-stop-dma-before-reset.patch
	: stop dma before reset

	AHCI 1.1 mandates stopping dma before issueing COMMRESET.  The
	original code didn't and it resulted in occasional lockup of
	the controller during EH recovery.  This patch fixes the
	problem.

08_NCQ_remove-or-unexport-unused-functions.patch
	: remove/unexport unused/unnecessary functions

	This patch removes ata_scsi_block_requests() and
	ata_scsi_unblock_requests(), and makes ata_read_log_page() and
	ata_to_sense_error() static.

09_NCQ_ahci-debug.patch
	: causes error or timeout

	This is what I've used for testing EH.  This patch contains
	codes for corrupting or skipping specific tags causing error
	conditions.  If you're curious....

[ End of patch descriptions ]

 Thanks a lot.

--
tejun

