From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] libata: fix shutdown warning message printing
Date: Mon, 14 May 2007 10:45:02 -0500
Message-ID: <1179157502.3703.37.camel@mulgrave.il.steeleye.com>
References: <46487F9A.1080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:39160 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752016AbXENPpJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 11:45:09 -0400
In-Reply-To: <46487F9A.1080309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Mon, 2007-05-14 at 17:26 +0200, Tejun Heo wrote:
> Unlocking ap->lock and ssleeping don't work because SCSI commands can
> be issued from completion path without context.  Reimplement delayed
> completion by allowing translation functions to override
> qc->scsidone(), storing the original completion function to
> scmd->scsi_done() and overriding qc->scsidone() with a function which
> schedules delayed invocation of scmd->scsi_done().
> 
> This isn't pretty at all but all the ugly parts are thankfully
> contained in the stop translation path where the compat feature is
> implemented.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Heh, very clever, but a bit of  a hack (however, no better way I can see
to do it given the layering constraints).

Acked-by: James Bottomley <James.Bottomley@SteelEye.com>

James


