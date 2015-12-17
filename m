From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [v6 6/7] phy: phy_brcmstb_sata: add data for phy version
Date: Wed, 16 Dec 2015 16:46:58 -0800
Message-ID: <56720602.3060906@gmail.com>
References: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com> <1448506595-4981-7-git-send-email-jaedon.shin@gmail.com> <5656E75F.9020701@cogentembedded.com> <566FEF9F.6040006@ti.com> <8DDEF728-5E23-4357-98CB-F7D599F16337@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34517 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966663AbbLQArN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Dec 2015 19:47:13 -0500
Received: by mail-pa0-f44.google.com with SMTP id wq6so32259267pac.1
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2015 16:47:12 -0800 (PST)
In-Reply-To: <8DDEF728-5E23-4357-98CB-F7D599F16337@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-ide@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>

On 15/12/15 03:23, Jaedon Shin wrote:
>>>   So an uninitialized .data field would mean the same?
>>
>> Are you planning to fix this?
>>
>> Thanks
>> Kishon
> 
> No, I do not have a plan in this version.
> 
> Of course, It is good that correspond to the case of NULL, but a .data field is not 
> empty at any time. I'm sure it must have BRCM_SATA_PHY_28NM or BRCM_SATA_PHY_40NM.
> 
> And Sergei, thanks to your good point.

I really do not this as a blocker to get these patches merged, and it
seems like we will miss another merge window on nitpicking if we
continue that route. Can we get these patches merged or are there more
blocking issues to be fixed?
-- 
Florian
