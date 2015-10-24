From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
Date: Sat, 24 Oct 2015 13:51:10 +0900
Message-ID: <E3E038D1-BD83-49D8-887A-B215AA685701@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <20151023035817.GA18907@mtj.duckdns.org> <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34392 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbJXEvO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Oct 2015 00:51:14 -0400
In-Reply-To: <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>

On Oct 23, 2015, at 1:51 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> 2015-10-22 20:58 GMT-07:00 Tejun Heo <tj@kernel.org>:
>> On Fri, Oct 23, 2015 at 10:44:13AM +0900, Jaedon Shin wrote:
>>> Hi all,
>>> 
>>> This patch series adds support SATA for BMIPS_GENERIC.
>>> 
>>> Ralf,
>>> I request you to drop already submitted patches for NAND device nodes.
>>> It is merge conflicts with this patches.
>>> http://patchwork.linux-mips.org/patch/10577/
>>> http://patchwork.linux-mips.org/patch/10578/
>>> http://patchwork.linux-mips.org/patch/10579/
>>> http://patchwork.linux-mips.org/patch/10580/
>>> 
>>> Jaedon Shin (10):
>>>  ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
>>>  ata: ahch_brcmstb: add data for port offset
>>>  ata: ahci_brcmstb: add support 40nm platforms
>> 
>> ata part looks fine to me.  Let me know when the other parts get in.
>> I'll apply the ata ones to libata/for-4.4.
> 
> There are a few comments coming on the ATA and Device Tree part, and I
> also would like Brian Norris (who submitted the patches) to take a
> look at these. But overall, this looks great.
> 
> I think we have a bit too many compatible strings defined, I need to
> lookup tomorrow when I am back in the office which BCM7xxx started
> featuring a SATA3 AHCI compliant core, it might be 7420, but I am not
> sure
> 

I agree with you. If you have good opinion, I want you to tell me.

> Thanks!
> -- 
> Florian

I will review carefully and submit v2 revision.

Regards,

Jaedon
