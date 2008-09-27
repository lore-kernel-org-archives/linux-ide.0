From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE driver
Date: Sat, 27 Sep 2008 18:59:55 +0200
Message-ID: <200809271859.55304.bzolnier@gmail.com>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:64091 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbYI0R3A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 13:29:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so963906fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 10:28:58 -0700 (PDT)
In-Reply-To: <48DA1F9D.6000501@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org


On Wednesday 24 September 2008, Sergei Shtylyov wrote:

[...]

> > @@ -70,41 +59,18 @@ static const struct ide_port_info swarm_
> >   * swarm_ide_probe - if the board header indicates the existence of
> >   * Generic Bus IDE, allocate a HWIF for it.
> >   */
> > -static int __devinit swarm_ide_probe(struct device *dev)
> > +static int __devinit swarm_ide_probe(struct platform_device *pdev)
> >  {
> >  	u8 __iomem *base;
> >  	struct ide_host *host;
> >  	phys_t offset, size;
> > +	struct resource *r;
> >  	int i, rc;
> >  	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
> >  
> > -	if (!SIBYTE_HAVE_IDE)
> > -		return -ENODEV;
> > -
> > -	base = ioremap(A_IO_EXT_BASE, 0x800);
> > -	offset = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_START_ADDR, IDE_CS));
> > -	size = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_MULT_SIZE, IDE_CS));
> > -	iounmap(base);
> > -
> > -	offset = G_IO_START_ADDR(offset) << S_IO_ADDRBASE;
> > -	size = (G_IO_MULT_SIZE(size) + 1) << S_IO_REGSIZE;
> > -	if (offset < A_PHYS_GENBUS || offset >= A_PHYS_GENBUS_END) {
> > -		printk(KERN_INFO DRV_NAME
> > -		       ": IDE interface at GenBus disabled\n");
> > -		return -EBUSY;
> > -	}
> > -
> > -	printk(KERN_INFO DRV_NAME ": IDE interface at GenBus slot %i\n",
> > -	       IDE_CS);
> > -
> > -	swarm_ide_resource.start = offset;
> > -	swarm_ide_resource.end = offset + size - 1;
> > -	if (request_resource(&iomem_resource, &swarm_ide_resource)) {
> >   
> 
>    Why drop request_resource() completely? Replace it by 
> request_mem_region().

Yes, this needs fixing (otherwise everything looks good).

Ralf: I guess that your next step will be dropping swarm-specific platform ide
driver in favor of generic one (please see drivers/ide/legacy/ide_platform.c)
as they are _very_ similar now? :)

Thanks,
Bart
