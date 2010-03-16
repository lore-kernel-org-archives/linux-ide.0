From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 16 Mar 2010 23:50:23 +0900
Message-ID: <4B9F9AAF.6080709@kernel.org>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>	 <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>	 <4B9EED55.10201@kernel.org> <1268720060.21384.10.camel@mulgrave.site>	 <4B9F2388.2030803@kernel.org> <1268745897.21384.14.camel@mulgrave.site>	 <4B9F8E1A.2020608@kernel.org> <1268749297.21384.15.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44572 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965256Ab0CPOr5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Mar 2010 10:47:57 -0400
In-Reply-To: <1268749297.21384.15.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

Hello,

On 03/16/2010 11:21 PM, James Bottomley wrote:
>>> For msdos labels, it's embedded in the label ... for all other labels,
>>> it's made up on the spot.
>>
>> Where in the label?
> 
> No idea ... I only know you can use fdisk expert mode to change the
> C/H/S layout and the change is preserved across reboots.

The CHS addresses are stored alongside with the LBA addresses.  The
problem is that the geometry parameters (sectors/track and heads/cyl)
are not stored anywhere and CHS addresses don't make any sense without
the two parameters.  The only way to figure out the geometry
parameters is to solve two equations involving CHS addresses and LBA
addresses.

e.g.  If the first partition begins at CHS 0/32/33 and ends at
12/233/19 and the corresponding LBA addresses are 2048 and 206848, you
can solve the equation and determine that the parameters gotta be 63
secs/trk and 255 heads/cyl to make those two pairs of addresses match
each other and in fact some BIOSs try to do this depending on
configuration (and sometimes falls into infinite loop or causes other
boot related problems if the parameters are too uncommon).

This method can't work reliably even at theoretical level because it
requires at least two pairs of CHS/LBA addresses to match (two unknown
parameters to solve for) and there is only single pair available if
the first partition goes over the CHS limit which at maximum is 8GiB.

So, CHS *values* are preserved if it falls below the CHS limit of the
geometry used during partitioning but the geometry information is lost
making the CHS values completely meaningless, so the only sane thing
to do is to stick to whatever geometry parameters provided by the BIOS
which usually is 255/63 these days.  Otherwise, the results are...

* If the first partition ends before the CHS limit and BIOS is
  configured to calculate back the parameters, BIOS may be able to
  report the geometry correctly.

* If the first partition goes over the CHS limit,

  * BIOS can use 255/63 or whatever default parameters and CHS and LBA
    addresses won't match each other which won't be a problem for
    modern OSes as they don't look at the CHS addresses at all but
    older operating systems which consider both CHS and LBA addresses
    may get confused.

  * BIOS can set up arbitrary parameters such that the CHS and LBA for
    the start of the first partition match and maybe also try to
    cylinder align further LBA addresses but there is no guarantee
    these parameters match the original parameters used during
    partitioning and this seems to cause more compatibility problems
    than it solves.

Thanks.

-- 
tejun
