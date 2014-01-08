From: Lior Amsalem <alior@marvell.com>
Subject: RE: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
Date: Wed, 8 Jan 2014 15:45:31 +0200
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801C034BF2AD1@IL-MB01.marvell.com>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
 <20131231121214.GB3985@htj.dyndns.org> <20131231170515.GG32537@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40553 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756464AbaAHNqL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jan 2014 08:46:11 -0500
In-Reply-To: <20131231170515.GG32537@lunn.ch>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Tejun Heo <tj@kernel.org>
Cc: Simon Guinot <simon.guinot@sequanux.org>, Jeff Garzik <jgarzik@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>

Hi Andrew,

> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Tuesday, December 31, 2013 7:05 PM
> 
> On Tue, Dec 31, 2013 at 07:12:14AM -0500, Tejun Heo wrote:
> > On Mon, Dec 23, 2013 at 01:07:35PM +0100, Simon Guinot wrote:
> > > @@ -1358,6 +1359,7 @@ static int mv_scr_write(struct ata_link *link,
> > > unsigned int sc_reg_in, u32 val)
> > >
> > >  	if (ofs != 0xffffffffU) {
> > >  		void __iomem *addr = mv_ap_base(link->ap) + ofs;
> > > +		void __iomem *lp_phy_addr = mv_ap_base(link->ap) +
> LP_PHY_CTL;
> > >  		if (sc_reg_in == SCR_CONTROL) {
> > >  			/*
> > >  			 * Workaround for 88SX60x1 FEr SATA#26:
> > > @@ -1374,6 +1376,14 @@ static int mv_scr_write(struct ata_link *link,
> unsigned int sc_reg_in, u32 val)
> > >  			 */
> > >  			if ((val & 0xf) == 1 || (readl(addr) & 0xf) == 1)
> > >  				val |= 0xf000;
> > > +
> > > +			/*
> > > +			 * Setting PHY speed according to SControl speed
> > > +			 */
> > > +			if ((val & 0xf0) == 0x10)
> > > +				writelfl(0x7, lp_phy_addr);
> > > +			else
> > > +				writelfl(0x227, lp_phy_addr);
> >
> > Do we know that this is safe for all sata_mvs?  If other sata_mvs
> > haven't had the described issue, maybe this should be applied
> > selectively to the said soc?  I'd actually prefer to avoid such
> > conditionals but we need to confirm this is okay for other
> > implementations.
> 
> Hi Tejun
> 
> I've tested on Kirkwood, and not had problems. But i agree with you. We
> need somebody in Marvell to say this is safe with all sata_mv variants.
> 
> Lior, can you comment?

This register (0x58) was introduced in a370/axp (with a new SATA PHY version).
In other SoCs the register does not exist.

Writing/reading the registers on A300/A310 will not cause any harm (I haven't
tried A510).
But, I think it's better to check if we're running on A370/AXP. (maybe with a new
compatibility string in DT?)

> 
> Thanks
> 	Andrew


Regards,
Lior Amsalem

