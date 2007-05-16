From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix shutdown warning message printing
Date: Wed, 16 May 2007 01:22:01 -0400
Message-ID: <464A94F9.5030300@garzik.org>
References: <46487F9A.1080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53458 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760131AbXEPFWE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 May 2007 01:22:04 -0400
In-Reply-To: <46487F9A.1080309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, James Bottomley <James.Bottomley@SteelEye.com>, Andrew Morton <akpm@linux-foundation.org>

Tejun Heo wrote:
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

applied to #upstream-fixes


