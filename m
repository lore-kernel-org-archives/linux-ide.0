From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 17 Mar 2010 00:47:28 +0900
Message-ID: <4B9FA810.5000605@kernel.org>
References: <4B947393.2050002@kernel.org>	 <1268745897.21384.14.camel@mulgrave.site>	 <4B9F8E1A.2020608@kernel.org>	 <201003161538.27015.vda.linux@googlemail.com>	 <4B9F9FD0.8040303@kernel.org> <1158166a1003160825j16ce6573h73e64d85b58bb202@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55249 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755855Ab0CPPpI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Mar 2010 11:45:08 -0400
In-Reply-To: <1158166a1003160825j16ce6573h73e64d85b58bb202@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: James Bottomley <James.Bottomley@suse.de>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

Hello,

On 03/17/2010 12:25 AM, Denys Vlasenko wrote:
>> C/H/S of 1023/254/63 is a special marker indicating the value there is
>> out-of-range.
> 
> You misunderstood my ^^^ markers. I was trying to highlight
> the whole columns of "end head" and "end sector", not the
> last partition's 1023/254/63 values.
>
> In the partition table like shown above it is obvious
> that geometry is 255/63.

Oh, if you have at least one partition contained under the CHS limit,
you can definitely determine the parameters.  You need to know two
params and there are two equations.  You don't even have to consider
the alignment.

>> We don't have to align to cylinders either.
> 
> If neither the start nor the end is aligned to cylinder's end
> and disk has just one partition and it's bigger than 8G,
> there is not way to determine geometry.
> 
> If everybody adopts the convention of ending the partitions
> at the cylinder end, geometry can be trivially determined by
> looking at partition end values. Sans "no of cylinders" value,
> which can be easily determined by other means.

But this is irrelevant because we don't and can't control everybody.
Actually, nobody can.  Codes dealing with partition tables have
already been out there for a very long time and there's no way to
retroactively make them agree on anything.  The only reason why we
care about CHS values at all is backward compatibility.  Going
forward, we don't need them at all.

Thanks.

-- 
tejun
