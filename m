From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 3/4] ata: add new-style AHCI platform driver for DaVinci
 DA850 AHCI controller
Date: Thu, 20 Mar 2014 16:07:04 +0100
Message-ID: <348852006.YgTlFegqas@amdc1032>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
 <532AA2B0.1060103@ti.com> <2662651.GJX9HVKij5@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:20227 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758109AbaCTPHX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2014 11:07:23 -0400
In-reply-to: <2662651.GJX9HVKij5@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tejun Heo <tj@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, spear-devel@list.st.com

On Thursday, March 20, 2014 01:57:10 PM Bartlomiej Zolnierkiewicz wrote:

> > > +#define DA8XX_SYSCFG1_VIRT(x)	(da8xx_syscfg1_base + (x))
> > > +#define DA8XX_PWRDN_REG		0x18
> > > +
> > > +/* SATA PHY Control Register offset from AHCI base */
> > > +#define SATA_P0PHYCR_REG	0x178
> > > +
> > > +#define SATA_PHY_MPY(x)		((x) << 0)
> > > +#define SATA_PHY_LOS(x)		((x) << 6)
> > > +#define SATA_PHY_RXCDR(x)	((x) << 10)
> > > +#define SATA_PHY_RXEQ(x)	((x) << 13)
> > > +#define SATA_PHY_TXSWING(x)	((x) << 19)
> > > +#define SATA_PHY_ENPLL(x)	((x) << 31)
> > 
> > These can be replaced with BIT(N)
> 
> OK, I'll fix it.

Uh, no, we can't use BIT() here.

BIT(N) does (1UL << (N)) and here we have ((N) << offset).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

