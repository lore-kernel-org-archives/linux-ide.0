From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH RFC v4 10/10] ahci_imx: Port to library-ised ahci_platform
Date: Wed, 22 Jan 2014 07:51:51 +0100
Message-ID: <20140122065151.GC16215@pengutronix.de>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
 <1390236303-22538-11-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38709 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaAVGwC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jan 2014 01:52:02 -0500
Content-Disposition: inline
In-Reply-To: <1390236303-22538-11-git-send-email-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Oliver Schinagl <oliver@schinagl.nl>, Maxime Ripard <maxime.ripard@free-electrons.com>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, Roger Quadros <rogerq@ti.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

Hi Hans,

On Mon, Jan 20, 2014 at 05:45:03PM +0100, Hans de Goede wrote:
> This avoids the ugliness of creating a nested platform device from probe.
> 
> Note untested, I've ordered a wandboard to be able to test these changes.

Looks much better now, thanks. I could test this patch aswell, no need
to buy new hardware for this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
