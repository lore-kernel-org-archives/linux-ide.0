From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch][3/9] ide: add ide_sg_init() helper
Date: Thu, 9 Sep 2004 17:31:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200409091731.23439.bzolnier@elka.pw.edu.pl>
References: <200409082126.49832.bzolnier@elka.pw.edu.pl> <200409091554.41718.bzolnier@elka.pw.edu.pl> <20040909144705.GD1737@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S265910AbUIIPhd@vger.kernel.org>
In-Reply-To: <20040909144705.GD1737@suse.de>
Content-Disposition: inline
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 09 September 2004 16:47, Jens Axboe wrote:
> On Thu, Sep 09 2004, Bartlomiej Zolnierkiewicz wrote:
> > 
> > On Thursday 09 September 2004 05:17, Jeff Garzik wrote:
> > > Bartlomiej Zolnierkiewicz wrote:
> > > > +static inline void ide_sg_init(struct scatterlist *sg, u8 *buf, unsigned int buflen)
> > > > +{
> > > > +	memset(sg, 0, sizeof(*sg));
> > > > +
> > > > +	sg->page = virt_to_page(buf);
> > > > +	sg->offset = offset_in_page(buf);
> > > > +	sg->length = buflen;
> > > > +}
> > > > +
> > > 
> > > 
> > > Surely this should be more generic?
> > 
> > Any idea where to put it? linux/blkdev.h?
> 
> How about asm/scatterlist.h?

I would like to avoid duplicating it for every arch
as it is not arch specific.
