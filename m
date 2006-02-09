From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/13] libata: fix handling of race between timeout and
 completion
Date: Thu, 09 Feb 2006 01:21:23 -0500
Message-ID: <43EADF63.70605@pobox.com>
References: <11379893774038-git-send-email-htejun@gmail.com> <43D999CF.7020707@pobox.com> <20060201153658.GA4311@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:13721 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422819AbWBIGV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 01:21:28 -0500
In-Reply-To: <20060201153658.GA4311@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> SCSI EH never invokes ->eh_strategy_handler without any failed
> scsicmd.  The only case where qc <-> scmd mismatch occurs is the
> following case.
> 
> 1. SCSI issues command (timer activated)
> 2. libata interprets and issues
> 3. time passes
> 4. SCSI timeout occurs, scmd queued for EH
> 5. irq occurs, completes qc.  ata_qc_complete() calls qc->complete_fn
>    which ends up calling scsi_done().  scsi_done() sees that SCSI
>    timer has already expired, so it returns without doing anything
>    expecting EH to clean up.
> 6. SCSI EH kicks in, libata ->eh_strategy_handler (ata_scsi_error)
>    invoked.
> 7. in libata EH, we have no active qc but scmds to recover.


OK, I agree with your analysis of the problem above.

However...   [see next email, commenting on patch #3]

	Jeff


