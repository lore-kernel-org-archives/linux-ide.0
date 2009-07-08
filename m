From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use HORKAGE_NOSETXFER
Date: Wed, 08 Jul 2009 20:16:06 +0900
Message-ID: <4A547FF6.7010609@kernel.org>
References: <1229894315.6931.17.camel@Thutmosis>	<494EDDBE.3010306@shaw.ca>	<494F65C1.80602@kernel.org>	<1229947998.6045.10.camel@Thutmosis>	<49505500.8080409@kernel.org>	<1230126055.6430.17.camel@Thutmosis>	<495886E7.7050204@kernel.org>	<1230586376.11130.46.camel@Thutmosis>	<1231282276.6376.13.camel@Thutmosis>	<49640CE1.6070808@kernel.org>	<20090107094043.580f5bf7@lxorguk.ukuu.org.uk>	<496483A5.6020105@kernel.org>	<20090107105339.289f47a4@lxorguk.ukuu.org.uk>	<49648C41.6030002@kernel.org>	<4A1A0C1B.7020801@kernel.org>	<20090525091110.626da5f8@lxorguk.ukuu.org.uk>	<4A545236.6080808@kernel.org> <20090708111413.7bb25e1e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48520 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbZGHLRd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jul 2009 07:17:33 -0400
In-Reply-To: <20090708111413.7bb25e1e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CDD-6w99-4@reply.e4ward.com, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, peter.klotz@aon.at, linux-ide@vger.kernel.org, m.nov4k@gmail.com, lars21ce@gmx.de

Alan Cox wrote:
>> That isn't possible because the host machine state is unknown after a
>> timeout.  The problem is not confined to TF based controllers and even
>> on TF based controllers, it's far too dangerous to continue as nothing
>> happened.  That can easily lead to complete system lock up on quite a
>> few controllers due to fragile TF emulation layer.
> 
> It works fine on old style taskfile controllers, and the old IDE layer
> has done it for years

Yeah, exactly.  libata covers more diverse set of controllers and
nothing has ever been tested for issuing commands without full reset
after exceptions which can put HSM into unknown state.  The whole EH
is designed and implemented that way.  So, many reset methods reset
not only the ATA bus but also the HSM.  This also coincides with
hardware design.  So, if the problem is confined to TF based old IDE,
issuing commands after timeout could work fine but I don't think
that's a viable option here.

>> The drive is full SATA.  SETXFER doesn't mean anything to it.  Let's
>> just skip it.
> 
> What if there is a bridge, what if the controller needs SETXFER for
> internal use (HPT PATA with on card SATA bridges) ?

The device is horridly broken.  I don't think we can please everyone
here.  Also, it being a slim oem dvd which gets shipped with laptops,
I don't think we need to worry too much about highly varied
configurations.

> I have a feeling this is one case where there isn't a generic solution
> for all devices
> 
> For PATA we need SETXFER to be issued
> For SATA we can maybe avoid it sometimes but its getting into deeply
> undefined territory and will break the early HPT at least.

Sure, fully agreed.  It's a trade off.  There are three options.

1. Don't do anything.  The device is broken everywhere.

2. Skip SETXFER.  Any direct SATA connection to the device would work
   fine.

2. Ignore SETXFER timeout.  Probably would work for TF based
   controllers but it's largely untested for sata controllers and the
   behavior is likely undefined for more advanced controllers.

So, #2 seems like the logical choice here.  If worst comes to worst
and some idiot decides to ship the drive with SATA bridge (but really
how many of those configurations do we see anymore?), we can blacklist
that particular machine using dmi or whatnot and craft workaround such
that timeout is ignored for that particular case if it works.

Thanks.

-- 
tejun
