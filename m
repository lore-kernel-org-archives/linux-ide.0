From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 17 Mar 2010 00:37:02 +0900
Message-ID: <4B9FA59E.1000402@kernel.org>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>	 <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>	 <4B9EED55.10201@kernel.org> <1268720060.21384.10.camel@mulgrave.site>	 <4B9F2388.2030803@kernel.org> <1268745897.21384.14.camel@mulgrave.site>	 <4B9F8E1A.2020608@kernel.org> <1268749297.21384.15.camel@mulgrave.site>	 <4B9F9AAF.6080709@kernel.org> <1268751748.21384.18.camel@mulgrave.site>	 <4B9FA1C6.7090305@kernel.org> <1268752993.21384.23.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52702 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933100Ab0CPPfJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Mar 2010 11:35:09 -0400
In-Reply-To: <1268752993.21384.23.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de

Hello,

On 03/17/2010 12:23 AM, James Bottomley wrote:
>> So, using custom geometry doesn't help compatibility at all.
> 
> Our partitioning tool still obey the integral cylinder rule ... we can
> argue about whether they should, but what we need is a strategy for
> fixing what is rather than what should be.

The updated ones don't anymore.  They just align to 1MiB + whatever
the drive requests for offset (the offset-by-one thing).  They will
basically behave the same as windows vista/7 ones, so it's already
fixed.  What we can argue is whether adding CHS tricks on top to make
those larger alignments somewhat meaningful w/ CHS interpretation too,
which I'm objecting on the ground that it doesn't help compatibility
at all.

Thanks.

-- 
tejun
