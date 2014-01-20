From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC v3 08/13] ahci-platform: Allow specifying platform_data
 through of_device_id
Date: Mon, 20 Jan 2014 10:57:28 +0100
Message-ID: <20140120095728.GM16215@pengutronix.de>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
 <20140120082438.GH16215@pengutronix.de>
 <52DCDFBA.2070903@redhat.com>
 <20140120090950.GI16215@pengutronix.de>
 <52DCE9A4.50901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34062 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbaATJ5g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jan 2014 04:57:36 -0500
Content-Disposition: inline
In-Reply-To: <52DCE9A4.50901@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Oliver Schinagl <oliver@schinagl.nl>, Maxime Ripard <maxime.ripard@free-electrons.com>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

On Mon, Jan 20, 2014 at 10:17:24AM +0100, Hans de Goede wrote:
> Hi,
> 
> I'm currently working on a slightly different implementation of a more
> generic ahci_platform.c where ahci_platform.c exports some standard platform
> related functionality as library functions.
> 
> Drivers which need to override some of ahci_platform.c's behavior because of
> non standard hw, will then export their own struct platform_driver and can
> call into the exported functions for standard stuff to avoid code duplication
> where appropriate, while still having 100% freedom to do things in a custom
> way where necessary.

Nice, thanks.

> 
> I hope to post a PATCH RFC v4 with these changes later today, which you will
> hopefully like better. Input on v4, even just a "yep better" remark would be
> much appreciated.

Yes, I will give feedback on v4.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
