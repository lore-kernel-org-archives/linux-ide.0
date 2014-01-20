From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC v3 08/13] ahci-platform: Allow specifying platform_data
 through of_device_id
Date: Mon, 20 Jan 2014 10:09:50 +0100
Message-ID: <20140120090950.GI16215@pengutronix.de>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
 <20140120082438.GH16215@pengutronix.de>
 <52DCDFBA.2070903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57503 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbaATJJ7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jan 2014 04:09:59 -0500
Content-Disposition: inline
In-Reply-To: <52DCDFBA.2070903@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Oliver Schinagl <oliver@schinagl.nl>, Maxime Ripard <maxime.ripard@free-electrons.com>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

On Mon, Jan 20, 2014 at 09:35:06AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 01/20/2014 09:24 AM, Sascha Hauer wrote:
> >>+
> >>+static const struct ahci_platform_data *ahci_get_pdata(struct device *dev)
> >>+{
> >>+	struct ahci_platform_data *pdata;
> >>+	const struct of_device_id *of_id;
> >>+
> >>+	pdata = dev_get_platdata(dev);
> >>+	if (pdata)
> >>+		return pdata;
> >>+
> >>+	of_id = of_match_device(ahci_of_match, dev);
> >>+	if (of_id)
> >>+		return of_id->data;
> >
> >I don't think it's a good idea to force of_id->data to be of type struct
> >struct ahci_platform_data *. With this we don't have a place to store
> >SoC specific data anymore.
> 
> ?? ahci_platform_data *is* soc specific data, it allows various soc
> specific overrides.

I know, but it might not be enough for encding the slight differences
between i.MX53 and i.MX6. So you say then we would need to different
instances of struct ahci_platform_data, one for i.MX53 and one for
i.MX6. Ok, that works.

Overall I must say that I'm not really happy with giving up control over
the probe function and putting ahci_platform as a midlayer between the
SoC and the ahci lib. Just my 2 cents, if I'm the only one feel free to
ignore me, but maybe there are others that have the same feeling.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
