From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/12] libata: implement powersave timer
Date: Wed, 19 Jul 2006 15:48:21 -0400
Message-ID: <44BE8C85.2080008@pobox.com>
References: <11531191522801-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59785 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030250AbWGSTs0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2006 15:48:26 -0400
In-Reply-To: <11531191522801-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, axboe@suse.de
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement powersave timer.  It is primarily for OS-driven HIPS
> implementation but can be used for any other PS purpose LLD sees fit.
> During normal operation, PS timer is automatically started with
> timeout ap->ps_timeout on port idle and stopped when the port becomes
> busy.  The timer is also stopped while EH.
> 
> To minimize overhead and allow easy implementation of expected
> operation model, ata_ps_timer_worker() is used as timer callback which
> invokes LLD supplied ap->ps_timer_fn() if condition meets and also
> helps implementing sequenced multi-step operation.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

This makes me wonder what Jens thinks about having a device idle timer 
and callback at the block level?  At the very least, this feels like it 
should be implemented in the SCSI layer, or somewhere other than libata.

This is NOT a NAK, however.  The code looks OK, and if consensus is 
against doing this sort of thing in block or SCSI, then I'm OK with the 
current patch.

