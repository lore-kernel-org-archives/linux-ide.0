From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 00/11] libata: new error handling &
 NCQ generic helpers (review only)
Date: Sat, 20 Aug 2005 02:08:08 -0400
Message-ID: <4306C8C8.2010901@pobox.com>
References: <20050707130840.5046338C@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:737 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751080AbVHTGIT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 02:08:19 -0400
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:

> 01_libata_implement-ata_qc_exec_special.patch
> 	: implement ata_qc_exec_special()
> 
> 	This patch implements ata_qc_exec_special() function which
> 	generalizes libata internal special command execution and adds
> 	timeout.  All internal commands are converted.  Timeout
> 	constants are added to libata.h and, while at it, removed
> 	unused ATA_TMOUT_EDD.

this seems sane, though I wonder if it could be split up a bit more


> 02_libata_new-error-handling.patch
> 	: implement new EH framework and convert non-ncq EH
> 
> 	This patch implements new EH framework and converts non-ncq EH
> 	to use it.  Now errors and timeouts are all handled by EH
> 	handler inside EH thread.
> 
> 	* All failed commands are posted to EH by using ata_qc_error()
> 	  without qc-completion.  All timed out commands are posted to
> 	  EH, too.  On entry to EH handler, all active qc's are either
> 	  failed or timed out qc's, and they are all.  Also it's
> 	  guaranteed that once EH is started, only EH can finish or
> 	  retry it.  Normal or spurious interrupts during recovery
> 	  don't affect failed qc's.
> 
> 	* EH handles error and determines whether to retry or fail
> 	  qc's.  It is responsible for setting error information to
> 	  notify upper layer if it's gonna fail a command.  (Jeff,
> 	  this should make implementing error classes you've talked
> 	  about easier.  All error handling is done inside EH and we
> 	  can just set sense data appropriately and eh-complete the
> 	  commands.)
> 
> 	* After EH is complete, operation resumes.
> 
> 	The following changes are worth noting.
> 
> 	* ->eng_timeout renamed to ->error_handler
> 
> 	* ata_eh_qc_complete(), ata_eh_qc_retry() added
> 
> 	* __ata_qc_complete() used to deal with resource freeing and
> 	  completing wait for special cmds.  As this patch removes the
> 	  only use of __ata_qc_complete(), it's moved into
> 	  ata_qc_free() and ata_qc_free() deals only with resource
> 	  freeing.  New __ata_qc_complete() is defined to be used by
> 	  ata_eh_qc_*() functions (internal use only).
> 
> 	* After allocated, all commands are either freed with
>           ata_qc_free() if it can't be issued or completed with
>           ata[_eh]_qc_complete().  No half-completion anymore.
> 
> 	* As filling upper layer error info is the reponsibility of
> 	  the recovery handler now, qc->complete_fn() doesn't need
> 	  drv_stat argument.  Also, as all commands are completed
> 	  fully at once, there's no need for int return value.  This
> 	  leaves very little functionality to qc->complete_fn,
> 	  currently only ATAPI inquiry result tempering.  I think just
> 	  inlining that part and removing this callback will make the
> 	  code easier.
> 
> 	* Although it looks like a lot of changes, from a device's
> 	  point of view, nothing changes.  Only software structure is
> 	  changed.
> 
> 	This patch is separated out only to make changes incremental.
> 	I haven't really tested this patch alone.  Please test with
> 	the following NCQ EH patches applied.

this seems mostly OK, though I need to read it over again.  Definitely 
needs to be split up.  Things like the renaming should be moved to 
separate patches.


> 05_libata_add-drv_err-to-ata_to_sense_error.patch
> 	: add drv_err argument to ata_to_sense_error()
> 
> 	During NCQ error handling, drv_stat and drv_err values are
> 	obtained from log page 10h.  This patch adds drv_err argument
> 	to ata_to_sense_error() such that it can be used with values
> 	obtained from log page 10h.

Seems OK, though the s/err/drv_err/ should be a separate patch.


> 07_libata_convert-ahci-to-new-eh.patch
> 	: convert ahci driver to use new NCQ helpers
> 
> 	This patch converts ahci driver to use new NCQ helpers.

the start-DMA path seems a bit heavy, though if its ONLY used in EH 
paths, I suppose its OK.


> 08_libata_ahci-stop-dma-before-resetting.patch
> 	: stop dma before reset
> 
> 	AHCI 1.1 mandates stopping dma before issueing COMMRESET.  The
> 	original code didn't and it resulted in occasional lockup of
> 	the controller during EH recovery.  This patch fixes the
> 	problem.

patch should probably be bumped to the top of the list (modulo obvious 
dependencies)


