From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 16 Mar 2010 16:42:26 -0400
Message-ID: <4B9FED32.6080400@redhat.com>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>	 <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>	 <4B9EED55.10201@kernel.org> <1268720060.21384.10.camel@mulgrave.site>	 <4B9F2388.2030803@kernel.org> <1268745897.21384.14.camel@mulgrave.site>	 <4B9F8E1A.2020608@kernel.org> <1268749297.21384.15.camel@mulgrave.site>	 <4B9F9AAF.6080709@kernel.org> <1268751748.21384.18.camel@mulgrave.site>	 <4B9FA1C6.7090305@kernel.org> <1268752993.21384.23.camel@mulgrave.site> <4B9FA59E.1000402@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915Ab0CPUnY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Mar 2010 16:43:24 -0400
In-Reply-To: <4B9FA59E.1000402@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: James Bottomley <James.Bottomley@suse.de>, Denys Vlasenko <vda.linux@googlemail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de

On 03/16/2010 11:37 AM, Tejun Heo wrote:
> Hello,
>
> On 03/17/2010 12:23 AM, James Bottomley wrote:
>    
>>> So, using custom geometry doesn't help compatibility at all.
>>>        
>> Our partitioning tool still obey the integral cylinder rule ... we can
>> argue about whether they should, but what we need is a strategy for
>> fixing what is rather than what should be.
>>      
> The updated ones don't anymore.  They just align to 1MiB + whatever
> the drive requests for offset (the offset-by-one thing).  They will
> basically behave the same as windows vista/7 ones, so it's already
> fixed.  What we can argue is whether adding CHS tricks on top to make
> those larger alignments somewhat meaningful w/ CHS interpretation too,
> which I'm objecting on the ground that it doesn't help compatibility
> at all.
>
> Thanks.
>
>    

Dropping any mention of CHS seems to be the only sensible thing. Why 
waste any time to continue some myth about drives that no modern 
hardware supports (and then have the joy of explaining that to users)?

Talking about it only confuses people and in the worst case, could cause 
them to misalign their partitions by clinging to these pretend borders :-)

ric

