From: Tejun Heo <htejun@gmail.com>
Subject: Re: System freezes with kernel >2.6.19 - sata_nv
Date: Tue, 01 May 2007 04:24:28 +0200
Message-ID: <4636A4DC.8070606@gmail.com>
References: <46351BE2.70901@yahoo.de> <4635BF4A.3050509@gmail.com> <46367F58.7000609@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:35892 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbXEACZn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 22:25:43 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1783792wra
        for <linux-ide@vger.kernel.org>; Mon, 30 Apr 2007 19:25:42 -0700 (PDT)
In-Reply-To: <46367F58.7000609@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Stefan <gentoopower@yahoo.de>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> Tejun Heo wrote:
>> Stefan wrote:
>>> Hi folks,
>>>
>>> yesterday I upgraded  kernel 2.6.19 to 2.6.20 (gentoo kernel). Now my
>>> box locks up about 10 min after boot.
>>> After that I tested with a vanilla 2.6.21.1 it shows the same behavior.
>>> I'm attaching a kern log file from the 2.6.20. The 2.6.21.1 locked up so
>>> hard, that there was no trace left in the log file.
>>> If I switch back to 2.6.19 everything is fine again.
>>> If necessary I will hook up a laptop to this box, so I can capture
>>> messages via netconsole.
>>
>> Yes please.
>>
>>> This machine is running an AMD X2 64, NFORCE4 (ASUS A8N-E)
>>>
>>> I haven't been following the development of libata for a while, but from
>>> the 2.6.20 changelog It looks like there have been some major changes.
>>>
>>> Just let me know what kind of information you need in order to narrow it
>>> down.
>>
>> Does giving 'sata_nv.adma=0' kernel parameter make any difference?
> 
> If adma=0 words, then that means it's either an ADMA related problem or
> that SAMSUNG HD401LJ drive has some problems with NCQ (since ADMA off
> means NCQ off as well). I would say the latter is more likely.

I don't have first hand experience with the particular model but I'll be
surprised if they screwed their firmware up with new generation of
harddisks.  Firmware on the previous generation drives was pretty good
and they don't get worse usually.

> We should really have some kind of "noncq" kernel parameter we can use
> to help debugging these problems. Though, later kernels are supposed to
> switch it off automatically after too many errors..

Till now there hasn't been any case where a broken NCQ prevented a
machine from booting but, yeah, having such thing would be nice for
debugging.

-- 
tejun
