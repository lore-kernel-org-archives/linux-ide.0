From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata debugging: set initial dbg value
Date: Mon, 29 May 2006 01:10:11 -0400
Message-ID: <447A8233.2090409@pobox.com>
References: <20060529045302.GA4680@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:27838 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751181AbWE2FKO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 May 2006 01:10:14 -0400
In-Reply-To: <20060529045302.GA4680@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org

Borislav Petkov wrote:
> This patch sets the prerequisites for the new debugging scheme that more or
> less resembles Donald Becker's net driver example. This one liner doesn't
> change any functionality beside setting the appropriate debug level for the
> msg_enable control in the ata_port struct, which will be later used by the 
> ata_msg_* macros to control the amount of debug information sent to printk.
> 
> Signed-off-by: <petkov@uni-muenster.de>
> 
> 
> --- drivers/scsi/libata-core.c.orig	2006-05-28 10:09:48.000000000 +0200
> +++ drivers/scsi/libata-core.c	2006-05-28 10:10:19.000000000 +0200

Applied, though I had to apply it manually for two reasons:

1) Patch not properly rooted.  Patch should be applyable with
	patch -sp1 < patch
which means that you need another directory in front of the filename in 
the diff, i.e.
	--- linux/drivers/scsi/libata-core.c
	+++ linux-new/drivers/scsi/libata-core.c

2) git-applymbox refused to apply the patch, with a "failed to apply" 
reason.  Possibly this was due to my hand-editing of the lines describe 
in #1 above, but also its possible that you did not diff properly 
against libata-dev.git#upstream.  I don't know which.

