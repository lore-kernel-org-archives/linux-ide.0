From: Tejun Heo <htejun@gmail.com>
Subject: Re: Subject should be [PATCHSET libata-dev#upstream-fixes] libata:
 prefer hardreset, take #3
Date: Mon, 17 Mar 2008 18:36:20 +0900
Message-ID: <47DE3B94.2090501@gmail.com>
References: <12052096544056-git-send-email-htejun@gmail.com>	<47D60A9E.1060609@gmail.com>	<18397.39466.462694.412688@harpo.it.uu.se>	<47DDB898.6050001@gmail.com> <18398.10615.977550.334382@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:35604 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbYCQJg0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2008 05:36:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so6284012wah.23
        for <linux-ide@vger.kernel.org>; Mon, 17 Mar 2008 02:36:26 -0700 (PDT)
In-Reply-To: <18398.10615.977550.334382@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
>  > > With this patch in place the hard reset conversion does seem to
>  > > work Ok on a SATA300 TX4 card.
>  > [--snip--]
>  > > +	for(i = 0; i < 4/*XXX: how to detect # ports?*/ && host->ports[i] != ap; ++i)
>  > 
>  > host->n_ports?
>  > 
>  > > +		;
>  > > +	if (i >= 4) {
>  > > +		printk(KERN_ERR "%s: unable to map ap to ata_no\n", __FUNCTION__);
>  > > +		return sata_std_hardreset(link, class, deadline);
>  > > +	}
>  > > +	ata_no = pdc_port_no_to_ata_no(i, is_sataii_tx4);
>  > > +
>  > > +	hotplug_status = readl(mmio_base + hotplug_offset);
>  > > +
>  > > +	/* clear hotplug flags, mask hotplug ints */
>  > > +	hotplug_status |= (0x11 << ata_no);
>  > > +	hotplug_status |= (0x11 << ata_no) << 16;
>  > > +	writel(hotplug_status, mmio_base + hotplug_offset);
>  > > +	readl(mmio_base + hotplug_offset); /* flush */
>  > 
>  > I think this belongs to ->freeze().
>  > 
>  > > +	ret = sata_std_hardreset(link, class, deadline);
>  > > +
>  > > +	/* clear hotplug flags, unmask hotplug ints */
>  > > +	hotplug_status &= ~((0x11 << ata_no) << 16);
>  > > +	writel(hotplug_status, mmio_base + hotplug_offset);
>  > > +	readl(mmio_base + hotplug_offset); /* flush */
>  > 
>  > And this to ->thaw().
> 
> Thanks, I'll try these suggestions. Expect a new patch in a couple of days.

I'll update the patchset such that promise won't use hardreset by
default so that cleanup-sht-ops patchset can go in.  I'll merge your
change when you're ready (shouldn't require too much massaging anyway).

Thanks.

-- 
tejun
