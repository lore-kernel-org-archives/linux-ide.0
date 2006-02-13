From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Replace assert() with WARN_ON in drivers/scsi/libata-core.c
Date: Mon, 13 Feb 2006 18:44:16 -0500
Message-ID: <43F119D0.5080103@pobox.com>
References: <20060213233518.15196.57162.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:56300 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964885AbWBMXoa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Feb 2006 18:44:30 -0500
In-Reply-To: <20060213233518.15196.57162.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aubin LaBrosse <aubin@stormboxes.com>
Cc: linux-ide@vger.kernel.org

Aubin LaBrosse wrote:
> Replace assert() with WARN_ON in drivers/scsi/libata-core.c
> 
> This is my first patch to the kernel - this work was suggested by Jeff Garzik as a janitorial task for libata.  If I could get some feedback letting me know that this is the correct format and my tools are setup right, I'll do the rest of these.
> 
> Signed-off-by: Aubin LaBrosse <aubin@stormboxes.com>
> ---
> 
>  drivers/scsi/libata-core.c |   46 ++++++++++++++++++++++----------------------
>  1 files changed, 23 insertions(+), 23 deletions(-)

Someone already beat you to it :)

I looked over your patch anyway.  It looks acceptable, except we avoid 
the '~' style in such tests:

+	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
+	WARN_ON(~qc->flags & ATA_QCFLAG_ACTIVE);

	Jeff


