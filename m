From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch][3/9] ide: add ide_sg_init() helper
Date: Thu, 9 Sep 2004 15:54:41 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409091554.41718.bzolnier@elka.pw.edu.pl>
References: <200409082126.49832.bzolnier@elka.pw.edu.pl> <413FCB61.7060604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:37081 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S264377AbUIIN4Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Sep 2004 09:56:25 -0400
In-Reply-To: <413FCB61.7060604@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Thursday 09 September 2004 05:17, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > +static inline void ide_sg_init(struct scatterlist *sg, u8 *buf, unsigned int buflen)
> > +{
> > +	memset(sg, 0, sizeof(*sg));
> > +
> > +	sg->page = virt_to_page(buf);
> > +	sg->offset = offset_in_page(buf);
> > +	sg->length = buflen;
> > +}
> > +
> 
> 
> Surely this should be more generic?

Any idea where to put it? linux/blkdev.h?
