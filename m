From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
Date: Thu, 22 Oct 2015 21:51:30 -0700
Message-ID: <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <20151023035817.GA18907@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36431 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbbJWEwK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 00:52:10 -0400
In-Reply-To: <20151023035817.GA18907@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jaedon Shin <jaedon.shin@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Kevin Cernekee <cernekee@gmail.com>

2015-10-22 20:58 GMT-07:00 Tejun Heo <tj@kernel.org>:
> On Fri, Oct 23, 2015 at 10:44:13AM +0900, Jaedon Shin wrote:
>> Hi all,
>>
>> This patch series adds support SATA for BMIPS_GENERIC.
>>
>> Ralf,
>> I request you to drop already submitted patches for NAND device nodes.
>> It is merge conflicts with this patches.
>> http://patchwork.linux-mips.org/patch/10577/
>> http://patchwork.linux-mips.org/patch/10578/
>> http://patchwork.linux-mips.org/patch/10579/
>> http://patchwork.linux-mips.org/patch/10580/
>>
>> Jaedon Shin (10):
>>   ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
>>   ata: ahch_brcmstb: add data for port offset
>>   ata: ahci_brcmstb: add support 40nm platforms
>
> ata part looks fine to me.  Let me know when the other parts get in.
> I'll apply the ata ones to libata/for-4.4.

There are a few comments coming on the ATA and Device Tree part, and I
also would like Brian Norris (who submitted the patches) to take a
look at these. But overall, this looks great.

I think we have a bit too many compatible strings defined, I need to
lookup tomorrow when I am back in the office which BCM7xxx started
featuring a SATA3 AHCI compliant core, it might be 7420, but I am not
sure

Thanks!
-- 
Florian
