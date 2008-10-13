From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RFC] pata_platform: add 8 bit data io support
Date: Mon, 13 Oct 2008 15:29:51 +0100
Message-ID: <20081013152951.53e548ee@lxorguk.ukuu.org.uk>
References: <20081011180014.GA4908@debian>
	<48F2F5EE.6060201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41021 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756548AbYJMOaN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 10:30:13 -0400
In-Reply-To: <48F2F5EE.6060201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Wang Jian <lark@linux.net.cn>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Mon, 13 Oct 2008 16:17:02 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Hello,
> 
> Wang Jian wrote:
> > +static void pata_platform_postreset(struct ata_link *link, unsigned int *classes)
> > +{
> > +	struct ata_port *ap = link->ap;
> > +	struct ata_device *dev;
> > +	u8 select = ATA_DEVICE_OBS;
> > +
> > +	/* Call default callback first */
> > +	ata_sff_postreset(link, classes);
> > +
> > +	if (!(ap->flags & ATA_FLAG_8BIT_DATA))
> > +		return;
> > +
> > +	/* Set 8-bit mode. We know we can do that */

Not really - the 8bit transfer command is CFA specific not ATA or ATAPI,
in addition it is not needed with most hardware that is running in 8bit
modes. 
