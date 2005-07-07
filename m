From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:ncq 00/11] libata: new error handling & NCQ generic helpers (review only)
Date: Thu,  7 Jul 2005 22:09:13 +0900 (KST)
Message-ID: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:24417 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261459AbVGGNJS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:09:18 -0400
Received: by wproxy.gmail.com with SMTP id 69so190583wra
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:09:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

 Hello, Jeff, Jens and Albert.

 This is the second take of generic NCQ completion/error-handling
patchset.  Changes are...

 * Generic special command helper (ata_qc_exec_special) added.  Now
   all internal commands run with timeout (request sense, read log,
   set xfer...)

 * New non-NCQ error handling to make EH paths more unified with NCQ
   case and ATAPI handling less hacky.  Now _all_ errors (NCQ or not)
   except for internal commands are posted to EH thread and handled
   there.  As was in ATAPI EH, all failed qc's are finished by EH
   thread.

 * NCQ helpers can now deal with ATAPI errors.

 This patchset is composed of the following parts.

 patches #01-#03: implement ata_qc_exec_special, new EH framework
		  and new non-NCQ error handling.
 patches #04-#08: implement NCQ helpers and convert & fix AHCI.
 patches #09-#11: misc stuff

 Currently this patchset only converts sata_sil, ata_piix and ahci.
All other drivers won't compile.

[ Start of patch descriptions ]

01_libata_implement-ata_qc_exec_special.patch
	: implement ata_qc_exec_special()

	This patch implements ata_qc_exec_special() function which
	generalizes libata internal special command execution and adds
	timeout.  All internal commands are converted.  Timeout
	constants are added to libata.h and, while at it, removed
	unused ATA_TMOUT_EDD.

02_libata_new-error-handling.patch
	: implement new EH framework and convert non-ncq EH

	This patch implements new EH framework and converts non-ncq EH
	to use it.  Now errors and timeouts are all handled by EH
	handler inside EH thread.

	* All failed commands are posted to EH by using ata_qc_error()
	  without qc-completion.  All timed out commands are posted to
	  EH, too.  On entry to EH handler, all active qc's are either
	  failed or timed out qc's, and they are all.  Also it's
	  guaranteed that once EH is started, only EH can finish or
	  retry it.  Normal or spurious interrupts during recovery
	  don't affect failed qc's.

	* EH handles error and determines whether to retry or fail
	  qc's.  It is responsible for setting error information to
	  notify upper layer if it's gonna fail a command.  (Jeff,
	  this should make implementing error classes you've talked
	  about easier.  All error handling is done inside EH and we
	  can just set sense data appropriately and eh-complete the
	  commands.)

	* After EH is complete, operation resumes.

	The following changes are worth noting.

	* ->eng_timeout renamed to ->error_handler

	* ata_eh_qc_complete(), ata_eh_qc_retry() added

	* __ata_qc_complete() used to deal with resource freeing and
	  completing wait for special cmds.  As this patch removes the
	  only use of __ata_qc_complete(), it's moved into
	  ata_qc_free() and ata_qc_free() deals only with resource
	  freeing.  New __ata_qc_complete() is defined to be used by
	  ata_eh_qc_*() functions (internal use only).

	* After allocated, all commands are either freed with
          ata_qc_free() if it can't be issued or completed with
          ata[_eh]_qc_complete().  No half-completion anymore.

	* As filling upper layer error info is the reponsibility of
	  the recovery handler now, qc->complete_fn() doesn't need
	  drv_stat argument.  Also, as all commands are completed
	  fully at once, there's no need for int return value.  This
	  leaves very little functionality to qc->complete_fn,
	  currently only ATAPI inquiry result tempering.  I think just
	  inlining that part and removing this callback will make the
	  code easier.

	* Although it looks like a lot of changes, from a device's
	  point of view, nothing changes.  Only software structure is
	  changed.

	This patch is separated out only to make changes incremental.
	I haven't really tested this patch alone.  Please test with
	the following NCQ EH patches applied.

03_libata_convert-drivers-to-new-eh.patch
	: convert sata_sil and ata_piix to use new EH

	This patch converts sata_sil and ata_piix to use new EH.

04_libata_implement-sactive.patch
	: implement ap->sactive

	This patch implements generic ap->sactive handling for NCQ
	commands.

05_libata_add-drv_err-to-ata_to_sense_error.patch
	: add drv_err argument to ata_to_sense_error()

	During NCQ error handling, drv_stat and drv_err values are
	obtained from log page 10h.  This patch adds drv_err argument
	to ata_to_sense_error() such that it can be used with values
	obtained from log page 10h.

06_libata_implement-ncq-helpers.patch
	: implement generic NCQ helpers

	This patch implements generic NCQ completion/error-handling
	helpers.

07_libata_convert-ahci-to-new-eh.patch
	: convert ahci driver to use new NCQ helpers

	This patch converts ahci driver to use new NCQ helpers.

08_libata_ahci-stop-dma-before-resetting.patch
	: stop dma before reset

	AHCI 1.1 mandates stopping dma before issueing COMMRESET.  The
	original code didn't and it resulted in occasional lockup of
	the controller during EH recovery.  This patch fixes the
	problem.

09_libata_remove-unused-eh-functions.patch
	: remove unused functions

	This patch removes ata_scsi_requeue(),
	ata_scsi_block_requests() and ata_scsi_unblock_requests().

10_libata_ahci-atapi.patch
	: add ATAPI support to ahci

	This patch adds ATAPI support to ahci driver.  This currently
	doesn't work.  I'll write a reply to this thread to tell more
	about this.  However, it at least shows that NCQ ATAPI error
	handling works.

11_libata_debug.patch
	: debug stuff

	As usual, debug messages and error triggers.

[ End of patch descriptions ]

 Please let me know what you guys think.

 Thanks.

--
tejun

