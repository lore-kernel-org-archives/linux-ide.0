From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 09/29] ide: __ide_do_rw_disk() lba48 dma check fix
Date: Thu, 3 Feb 2005 01:33:53 +0100
Message-ID: <58cb370e05020216334656aed2@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025142.GJ621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.204]:55861 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262642AbVBCAeM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 19:34:12 -0500
Received: by wproxy.gmail.com with SMTP id 67so167505wri
        for <linux-ide@vger.kernel.org>; Wed, 02 Feb 2005 16:34:11 -0800 (PST)
In-Reply-To: <20050202025142.GJ621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:51:42 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 09_ide_do_rw_disk_lba48_dma_check_fix.patch
> >
> >       In __ide_do_rw_disk(), the shifted block, instead of the
> >       original rq->sector, should be used when checking range for
> >       lba48 dma.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

good catch!  applied
