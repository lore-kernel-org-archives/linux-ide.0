From: Tejun Heo <htejun@gmail.com>
Subject: Re: Promise SATA TX4 300 port timeout with sata_promise in 2.6.22,
   kernel panic in 2.6.23
Date: Mon, 12 Nov 2007 17:58:38 +0900
Message-ID: <473815BE.4070607@gmail.com>
References: <6f048fc10711100443y6e9982b9jc00b3740f0a44d79@mail.gmail.com> <4737D2A3.6010103@gmail.com> <fh93nq$uif$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:47980 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbXKLI6v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 03:58:51 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1459786wah
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 00:58:51 -0800 (PST)
In-Reply-To: <fh93nq$uif$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patric Karlsson <patric@ce.chalmers.se>
Cc: linux-ide@vger.kernel.org

Patric Karlsson wrote:
> Tejun Heo wrote:
>> It seems those 3Gbps promise controllers have hard time getting out of
>> transmission errors.  Is it because hardreset doesn't work?  Can we
>> fix it?
>>
>> Also, if 3Gbps can't be made reliable on those controllers, how about
>> limiting it to 1.5Gbps by default with appropriate warning messages?
>> Without PMP, it's not like we're gonna earn anything by driving the
>> thing at 3Gbps.
> 
> I thought this was supposed to be fixed in 2.6.24-RC2 ?

Ah.... good news.

> Although I'm currently running a TX4 myself in 3Gbit mode with 2.6.23.1,
>  I'm waiting for 2.6.24 to reach stable until I try it out myself.
> 2.6.23.1 seemed to fix the hard-lock when it tried to reset the card
> tho, so now I just get a few errors about "soft resetting" in the logs.
> No data loss.

That's great too.

I Stratford, can you please give 2.6.24-rc2 a shot?

Thanks.

-- 
tejun
