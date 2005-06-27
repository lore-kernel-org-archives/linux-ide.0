From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata-dev-2.6-ncq: rewrite __ata_qc_complete
Date: Mon, 27 Jun 2005 10:27:10 +0200
Message-ID: <20050627082709.GO19550@suse.de>
References: <20050626144110.GD24968@htj.dyndns.org> <42BEE593.7050004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:20376 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261367AbVF0IZw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2005 04:25:52 -0400
Content-Disposition: inline
In-Reply-To: <42BEE593.7050004@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sun, Jun 26 2005, Jeff Garzik wrote:
> Tejun Heo wrote:
> > Hello, Jeff.
> > Hello, Jens.
> >
> > This is the fource, no, fourth (dang, that starwars) of six misc
> >updates to ncq.
> >
> > This patch rewrites __ata_qc_complete() to make it look more sane.
> >Also, remove spurious clearing of ATA_QCFLAG_ACTIVE from
> >ata_qc_complete().
> >
> > Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> I'll have to stare at this a bit more.  This has big potential for 
> creating races if not perfect.

It looks good to me.

-- 
Jens Axboe

