From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] fix sata_svw.c warnings for eeh_writeb, eeh_writew, eeh_readw
Date: Wed, 14 Sep 2005 16:53:52 -0400
Message-ID: <20050914205352.GA28124@havoc.gtf.org>
References: <20050914204924.GA31498@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:11966 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932513AbVINUxz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Sep 2005 16:53:55 -0400
Content-Disposition: inline
In-Reply-To: <20050914204924.GA31498@kvasir.watson.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Amos Waterland <apw@us.ibm.com>
Cc: benh@kernel.crashing.org, linux-ide@vger.kernel.org

On Wed, Sep 14, 2005 at 04:49:24PM -0400, Amos Waterland wrote:
> Right now drivers/scsi/sata_svw.c spews a lot of warnings like this:
> 
>  drivers/scsi/sata_svw.c: In function `k2_sata_tf_load':
>  drivers/scsi/sata_svw.c:111: warning: passing arg 2 of `eeh_writeb'
>                               makes pointer from integer without a cast
> 
> Looking at the definition for struct ata_ioports, the address fields are
> defined seemingly quite deliberately as unsigned longs.  So here is a
> patch that fixes the warnings by making the implicit cast explicit.
> 
> Signed-off-by: Amos Waterland <apw@us.ibm.com>

NAK, I reject this patch once every month or so.

The proper fix is to use iomap in libata.

	Jeff



