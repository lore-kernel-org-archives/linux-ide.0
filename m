From: Jens Axboe <axboe@suse.de>
Subject: Re: [patch][3/9] ide: add ide_sg_init() helper
Date: Thu, 9 Sep 2004 16:47:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040909144705.GD1737@suse.de>
References: <200409082126.49832.bzolnier@elka.pw.edu.pl> <413FCB61.7060604@pobox.com> <200409091554.41718.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S265195AbUIIOsn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200409091554.41718.bzolnier@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Sep 09 2004, Bartlomiej Zolnierkiewicz wrote:
> 
> On Thursday 09 September 2004 05:17, Jeff Garzik wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > +static inline void ide_sg_init(struct scatterlist *sg, u8 *buf, unsigned int buflen)
> > > +{
> > > +	memset(sg, 0, sizeof(*sg));
> > > +
> > > +	sg->page = virt_to_page(buf);
> > > +	sg->offset = offset_in_page(buf);
> > > +	sg->length = buflen;
> > > +}
> > > +
> > 
> > 
> > Surely this should be more generic?
> 
> Any idea where to put it? linux/blkdev.h?

How about asm/scatterlist.h?

-- 
Jens Axboe
