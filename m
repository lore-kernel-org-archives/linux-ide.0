From: Grant Grundler <grundler@google.com>
Subject: Re: Problems with >3 drives on an eSATA portmultiplier
Date: Wed, 1 Apr 2009 10:46:15 -0700
Message-ID: <da824cf30904011046x46da9b69u28f00472a49ebc20@mail.gmail.com>
References: <Pine.LNX.4.63.0904011454020.3947@buttercup.gerph.org>
	 <da824cf30904010945i5a33f049v15745c79293d22ad@mail.gmail.com>
	 <Pine.LNX.4.63.0904011801160.3947@buttercup.gerph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:39353 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbZDARqU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Apr 2009 13:46:20 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id n31HkHFq013261
	for <linux-ide@vger.kernel.org>; Wed, 1 Apr 2009 10:46:18 -0700
Received: from qyk10 (qyk10.prod.google.com [10.241.83.138])
	by zps35.corp.google.com with ESMTP id n31Hk3tE012553
	for <linux-ide@vger.kernel.org>; Wed, 1 Apr 2009 10:46:16 -0700
Received: by qyk10 with SMTP id 10so333931qyk.13
        for <linux-ide@vger.kernel.org>; Wed, 01 Apr 2009 10:46:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0904011801160.3947@buttercup.gerph.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Fletcher <gerph@gerph.org>
Cc: linux-ide@vger.kernel.org

On Wed, Apr 1, 2009 at 10:09 AM, Justin Fletcher <gerph@gerph.org> wrote:
> On Wed, 1 Apr 2009, Grant Grundler wrote:
>
>> On Wed, Apr 1, 2009 at 6:54 AM, Justin Fletcher <gerph@gerph.org> wrote:
>>>
>>> Hiya,
>>>
>>>
>>> The system I'm using is a MSI motherboard, with a SiI eSATA controller (a
>>> 3132, specifically this one:
>>> http://www.span.com/catalog/product_info.php?products_id=15995 )
>>> connected
>>> though the only PCI express card on the MB.
>>
>> 2.6.29 kernel + SII 3132 SATA controller should work fine with 3726 PMP.
>>
>> I'm skeptical it's a driver problem. But I've not tested recent
>> kernels with that config.
>> I do know 2.6.26 does work with that config.
>
> I could drop down to 2.6.26 and rebuild my kernel with support for that
> controller - I hadn't done this before because I cannot then use my DVB-S
> card, but... I could live without that for the test.

If someone could comment on  2.6.28 or 2.6.29, you could avoid running
this test.

...
> I've replaced the PSU once already - it was replaced on 6th Feb, with a
> Sumvision 450W 20+4pin SATA PSU. Those 5 drives + the bridge board and fan
> are the only things being powered by that PSU. I should have thought that
> even during drive initialisation 5 drives wouldn't exceed 450W. Anyhow, this
> was one of my first thoughts. I could get another PSU (I think I might be
> able to find one around here), but having replaced it so recently, I'm
> uncomfortable doing so.
>
> Is a 450W PSU going to be able to supply enough power for those drives ?

It's not just about how many watts. Both 12v and 5v "rails" need to
provide enough power.
But if this worked before, I would assume the replacement is working too.

And in general, yes, a 450W should be plenty for 5 drives plus PMP
board. Especially if
the OS is "staggering" the spinup so only one or two drives are
spinning up at the same time.
I know I've had to fix "staggered spinup" in the past (2.6.18) but
don't recall if it's fixed in current 2.6.28 or .29 kernels.

grant
