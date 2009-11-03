From: Mark Nelson <mdnelson8@gmail.com>
Subject: Re: [PATCH] ahci: Enable SB600 64bit DMA on MSI K9A2 Platinum
Date: Tue, 3 Nov 2009 19:57:46 +1100
Message-ID: <65a6ef750911030057t5d51653cncf9fa851407fba5@mail.gmail.com>
References: <65a6ef750910252203s58af446fv268c857191e698d3@mail.gmail.com>
	 <4AE5A330.3080506@kernel.org>
	 <65a6ef750910261605q45a08791h53cc2afd5d006bb3@mail.gmail.com>
	 <4AE7382F.20302@kernel.org>
	 <65a6ef750910271551i47858982xd1138e4a70a1b076@mail.gmail.com>
	 <65a6ef750910280449k5597d3abkc0995080954e5760@mail.gmail.com>
	 <4AE835A9.40806@kernel.org>
	 <65a6ef750910290132p75312231ub643b631ea43d7f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:50130 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbZKCI5m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Nov 2009 03:57:42 -0500
Received: by ewy3 with SMTP id 3so1739310ewy.37
        for <linux-ide@vger.kernel.org>; Tue, 03 Nov 2009 00:57:47 -0800 (PST)
In-Reply-To: <65a6ef750910290132p75312231ub643b631ea43d7f6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On Thu, Oct 29, 2009 at 7:32 PM, Mark Nelson <mdnelson8@gmail.com> wrote:
> On Wed, Oct 28, 2009 at 11:14 PM, Tejun Heo <tj@kernel.org> wrote:
>> Mark Nelson wrote:
>>> Things look promising so far with lots of DMAs above 4GB (snippets
>>> from syslog):
>>
>> It's probably working okay but a good test would be to repeat to copy
>> a large file and checksum it and verify checksums actually match.
>>
> Okay, I copied the following file:
>
> -rw-r--r-- 1 mark mark 8715024384 Oct 29 18:42 /home/mark/Test1.mpg
>
> and both the original and the copy came out with the same md5sum of
> c83d8da8fb1aa6843a3b94005278e8a7
>
> This is with BIOS version 1.8 though - I'll go back a few more versions and
> repeat these tests and see if I can find any that don't work with 64bit DMA.
>

I got some time to do the testing on more BIOSs and I found that all the
released BIOS versions worked correctly with 64bit DMA enabled, going all
the way back to version 1.0 (thankfully my CPU is old enough to work with
BIOS releases that old).

I guess this makes sense as version 1.0 is dated 2007-10-29, which is
around the time that the first correctly working Asus M2A-VM BIOS was
released. Or maybe it's just a coincidence... In any case, it looks like
we can enable 64bit DMA on this board regardless of BIOS version.

So, I've prepared a new patch that I'll send separately.

Thanks!
Mark
