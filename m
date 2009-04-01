From: Justin Fletcher <gerph@gerph.org>
Subject: Re: Problems with >3 drives on an eSATA portmultiplier
Date: Wed, 1 Apr 2009 18:09:20 +0100 (BST)
Message-ID: <Pine.LNX.4.63.0904011801160.3947@buttercup.gerph.org>
References: <Pine.LNX.4.63.0904011454020.3947@buttercup.gerph.org>
 <da824cf30904010945i5a33f049v15745c79293d22ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51075 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591AbZDARKA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Apr 2009 13:10:00 -0400
In-Reply-To: <da824cf30904010945i5a33f049v15745c79293d22ad@mail.gmail.com>
Content-ID: <Pine.LNX.4.63.0904011804341.3947@buttercup.gerph.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org

On Wed, 1 Apr 2009, Grant Grundler wrote:

> On Wed, Apr 1, 2009 at 6:54 AM, Justin Fletcher <gerph@gerph.org> wrote:
>> Hiya,
>>
>>
>> The system I'm using is a MSI motherboard, with a SiI eSATA controller (a
>> 3132, specifically this one:
>> http://www.span.com/catalog/product_info.php?products_id=15995 ) connected
>> though the only PCI express card on the MB.
>
> 2.6.29 kernel + SII 3132 SATA controller should work fine with 3726 PMP.
>
> I'm skeptical it's a driver problem. But I've not tested recent
> kernels with that config.
> I do know 2.6.26 does work with that config.

I could drop down to 2.6.26 and rebuild my kernel with support for that 
controller - I hadn't done this before because I cannot then use my DVB-S 
card, but... I could live without that for the test.

I'm unsure of where the problem might lie; if it's not a driver problem 
and the PSU isn't the issue, then the only variable left (I think) is the 
bridge board itself. AKA "The expensive bit" :-)

[snip]

>>
>> During testing combinations of drives have been changed, and the bridge
>> board ports that they are plugged in to. This has not appeared to make any
>> difference - the factor in this equation is the number of drives that are
>> connected.
>
> This suggests the power supply is now failing to provide adequate power
> for drive spinup. The WD "Green" drives certainly use less power during
> normal operation (IIRC, they are 5400 RPM and only 3 platter). But they
> will need substantially more to spinup.
>
> Happen to have another PSU that could provide power to the drives?
> Ie build the same topology with 3132 + 3726 but power it with a
> different (or multiple) PSU.

I've replaced the PSU once already - it was replaced on 6th Feb, with a 
Sumvision 450W 20+4pin SATA PSU. Those 5 drives + the bridge board and fan 
are the only things being powered by that PSU. I should have thought that 
even during drive initialisation 5 drives wouldn't exceed 450W. Anyhow, 
this was one of my first thoughts. I could get another PSU (I think I 
might be able to find one around here), but having replaced it so 
recently, I'm uncomfortable doing so.

Is a 450W PSU going to be able to supply enough power for those drives ?

-- 
Gerph <http://gerph.org/>
[ All information, speculation, opinion or data within, or attached to,
   this email is private and confidential. Such content may not be
   disclosed to third parties, or a public forum, without explicit
   permission being granted. ]
