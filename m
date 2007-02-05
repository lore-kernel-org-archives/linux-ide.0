From: Tejun Heo <htejun@gmail.com>
Subject: Re: Nvidia cable detection problems (was [PATCH] amd74xx: don't configure
 udma mode higher than BIOS did)
Date: Tue, 06 Feb 2007 04:15:55 +0900
Message-ID: <45C7826B.80707@gmail.com>
References: <20070205075836.GG1625@htj.dyndns.org> <45C72012.7050605@gmail.com>	 <20070205132247.6f611e3c@localhost.localdomain>	 <45C73A3E.6080700@gmail.com>	 <20070205143439.6962c076@localhost.localdomain>	 <45C7444F.4070500@gmail.com>	 <58cb370e0702050709w1b7682dr5dff9e7ce69465a@mail.gmail.com>	 <DBFABB80F7FD3143A911F9E6CFD477B01EC0DD7D@hqemmail02.nvidia.com>	 <20070205181224.3319d6c3@localhost.localdomain>	 <45C77921.4020808@gmail.com> <58cb370e0702051055w3c7dcff3wd3e3b4935b910b41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:17630 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933346AbXBETQH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 14:16:07 -0500
Received: by an-out-0708.google.com with SMTP id b33so1104993ana
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 11:16:06 -0800 (PST)
In-Reply-To: <58cb370e0702051055w3c7dcff3wd3e3b4935b910b41@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Allen Martin <AMartin@nvidia.com>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On 2/5/07, Tejun Heo <htejun@gmail.com> wrote:
>> Alan wrote:
>> >> The *real* solution is to use the BIOS ACPI _GTM _STM methods for
>> this.
>> >> Then you can remove all chipset specific knowledge from the IDE
>> driver.
>> >> This is what the MS driver does on Windows, so you know it's
>> received a
>> >> lot of testing from NVIDIA and board vendors.
> 
> Allen, thanks for quick reply.
> 
> Your mail explained the issue pretty well and saved us a lot of time.

My thanks too.

>> > Well we can certainly do some of that if ACPI is present and active. In
>> > particular since _GTM will give us current modes allowing for
>> hotplug and
>> > post BIOS boot kexec etc it ought to be safe to do Tejun's hack that
>> way.
>> > We could even probe UDMA3+ capable devices by doing _STM to a high mode
>> > and _GTM to determine the cable type 8)
> 
> agreed
> 
>> Glad to see the problem getting solved.  Now that we know the solution,
>> any volunteers?  :-)
> 
> Well, since you posted the initial patches and have the affected
> hardware... 8)

I'll be on the road for the next two weeks and Alan seems to have taken
it already.  :-)

-- 
tejun
