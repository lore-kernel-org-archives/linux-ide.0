From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 6/6] libata: switch to dynamic allocation insted of
 ata_scsi_rbuf
Date: Tue, 10 Jan 2017 06:40:54 -0800
Message-ID: <20170110144054.GA22597@infradead.org>
References: <1484037708-654-1-git-send-email-hch@lst.de>
 <1484037708-654-7-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757183AbdAJOk4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 09:40:56 -0500
Content-Disposition: inline
In-Reply-To: <1484037708-654-7-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org

>  	struct scsi_cmnd *scmd = qc->scsicmd;
>  	struct scsi_device *sdp = scmd->device;
> -	size_t len = sdp->sector_size;
> +	ssize_t len = sdp->sector_size;

Julia Lawall's magic checker tool pointed out that len doesn't have
to change to ssize_t here, but the size variable should instead so that
we can properly handle the ENOMEM case below.

I'll wait for some more feedback on the patches and will eventually
resend with that fix.
