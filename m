From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/5]: [PCI]: Remove 3 incorrect MSI quirks.
Date: Mon, 29 Oct 2007 15:13:48 +0900
Message-ID: <47257A1C.8050206@gmail.com>
References: <20071025.011716.123998434.davem@davemloft.net> <9783dadb0710260356g4ef94e3dvadf69d4d263c2361@mail.gmail.com> <20071026.043833.88113848.davem@davemloft.net> <5CAB7B5D6F8AB84AA868A46B47A50705623160@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:34980 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbXJ2GOF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 02:14:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1977086wah
        for <linux-ide@vger.kernel.org>; Sun, 28 Oct 2007 23:14:04 -0700 (PDT)
In-Reply-To: <5CAB7B5D6F8AB84AA868A46B47A50705623160@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <Shane.Huang@amd.com>
Cc: David Miller <davem@davemloft.net>, david.gaarenstroom@gmail.com, linux-kernel@vger.kernel.org, jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, gregkh@suse.de, brice.goglin@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com

Shane Huang wrote:
>> I would like those to be removed, but to be conservative we should
>> first get some testing feedback that confirms this just like those
>> provided to me from the AMD folks for the RS690, RX790 and RD580
>> cases.
>>
>> Otherwise the risk to break people's systems is very real.
> 
> In fact, our team only has boards with RS690+SB700 and RX790+SB700,
> I don't know why the RD580 MSI is disabled too by the patch
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
> t;h=aea6a433f50cd89b9cbd10850fd0b32f961f9883
> Maybe Tejun can give us more information on this case,
> I think the cause should be same as RS690 and RX790.

I don't remember history of each quirk entry but they're either reported
in a bug report and successfully worked around with pci=nomsi or one of
AMD guys told me certain PCI IDs share the same problem.  I can dig mail
archive if you wanna know how it went down for RD580.

-- 
tejun
