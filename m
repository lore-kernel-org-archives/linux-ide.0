From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Mon, 2 May 2005 18:01:59 +0200
Message-ID: <20050502160158.GB4817@suse.de>
References: <7A8F92187EF7A249BF847F1BF4903C040AFCD0@ausx2kmpc103.aus.amer.dell.com> <58cb370e050502084657287238@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:4527 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261356AbVEBQDH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 May 2005 12:03:07 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e050502084657287238@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "Stuart_Hayes@dell.com" <Stuart_Hayes@dell.com>, linux-ide@vger.kernel.org

On Mon, May 02 2005, Bartlomiej Zolnierkiewicz wrote:
> > The reason I went back to the kmap_atomic() fix instead of adding a
> > no-high-mem flag in the host is that I couldn't get James to accept that
> 
> What is no-high-mem flag?

In the host_template, to force scsi_calculate_bounce_limit() to set the
bounce address at the max_low_pfn point.

-- 
Jens Axboe

