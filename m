From: Jens Axboe <axboe@suse.de>
Subject: Re: libata vs ATAPI
Date: Thu, 14 Oct 2004 09:13:13 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041014071313.GF1454@suse.de>
References: <58cb370e04101213215ce9a23c@mail.gmail.com> <416C438C.4010902@pobox.com> <58cb370e0410121417591ecff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:19094 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269983AbUJNHPQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Oct 2004 03:15:16 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e0410121417591ecff0@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

On Tue, Oct 12 2004, Bartlomiej Zolnierkiewicz wrote:
> > libata enables DMA at the maximum level supported by both the device and
> > host controller.  I definitely want to do this by default.
> 
> Me too but I suppose that there are many devices which don't like it
> (otherwise restrictions in ide-cd and ide-scsi make no sense).
> 
> Jens?

There's no precedens for doing > 128KiB on ATAPI in Linux. Recently Pat
at Iomega tested 512/1024KiB requests and it worked fine. So if the
device works, we should be golden...

-- 
Jens Axboe

