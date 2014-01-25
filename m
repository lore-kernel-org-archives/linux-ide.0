From: Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH V2 4/8] SPEAr13xx: Fixup: Move SPEAr1340 SATA platform
 code to system cfg driver
Date: Sat, 25 Jan 2014 11:06:51 +0530
Message-ID: <CAHM4w1=We03RGnUdq5_tzTaLaMRK+a8MiAss6SRaDK=fWoqF_w@mail.gmail.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
	<201401231322.54914.arnd@arndb.de>
	<20140124042959.GC2369@pratyush-vbox>
	<201401242153.00848.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47207 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbaAYFgw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Jan 2014 00:36:52 -0500
In-Reply-To: <201401242153.00848.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pratyush Anand <pratyush.anand@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mohit KUMAR DCG <Mohit.KUMAR@st.com>, spear-devel <spear-devel@list.st.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Arnd,


On Sat, Jan 25, 2014 at 2:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Friday 24 January 2014, Pratyush Anand wrote:
> > On Thu, Jan 23, 2014 at 08:22:54PM +0800, Arnd Bergmann wrote:
> > > On Thursday 23 January 2014, Mohit Kumar wrote:
> > >
> > > I assume you'd want a phandle pointing to the syscon device in here
> > > as well?
> >
> > Since there is only one syscon device in the whole DT, so do I really
> > need to add phandle? Currently I am using
> > syscon_regmap_lookup_by_compatible to find  syscon device.
>
> I'd much rather use syscon_regmap_lookup_by_phandle than
> syscon_regmap_lookup_by_compatible, all the time, since this makes
> the relationship between the devices explicit.
>
> The phandle method also allows you to pass regmap indexes in the
> same property, which can be handy if two variants of the chip have
> the same registers at a different offset.
>
> > > > +/* SPEAr1340 Registers */
> > > > +/* Power Management Registers */

[...]

> > > Looking at the actual code now, this very much looks like it ought to
> > > be a "phy" driver and get put in drivers/phy/.
> >
> > Actually these registers are part of common system configurations
> > register space (called as misc space) for SPEAr SOC. So we opted for
> > syscon framework.
>
> The use of syscon for this is good, I have no objection to that, and
> was suggesting that you create a logical "phy" device that uses the
> misc syscon device as a backend.
>
> > PHY registers space starts from 0xEB800000, which can be
> > programmed for various phy specific functions like power management,
> > tx/rx settings, comparator settings etc. In most of the cases phy
> > works with default settings, however there are few exceptions for
> > which we will be adding a phy driver for further improvement of SPEAr
> > drivers.
>
> I see. So while the code you have here could be expressed as a phy driver
> by itself, there is another part of the SoC that controls the actual
> phy. How about if you add the phy device node to DT, and write a driver
> that doesn't actually program the phy registers for now, but does contain
> the code that you have posted here. That would give you flexibility for
> future extensions and at the same time let you remove all SPEAr specific
> code from the actual AHCI driver by using the generic ahci-platform
> driver.

OK..
--  will move all these code to a phy driver.
-- so, no need of a new cfg node as of now.
-- will pass syscon phandle to phy driver.
-- currently will keep ahci platform plugin (as it is here) in phy driver.
will remove when generic ahci driver is in place.

Regards
Pratyush
>
>         Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
