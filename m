From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
Date: Fri, 23 Oct 2015 12:58:17 +0900
Message-ID: <20151023035817.GA18907@mtj.duckdns.org>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35763 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbbJWD6Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2015 23:58:24 -0400
Content-Disposition: inline
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, devicetree@vger.kernel.org

On Fri, Oct 23, 2015 at 10:44:13AM +0900, Jaedon Shin wrote:
> Hi all,
> 
> This patch series adds support SATA for BMIPS_GENERIC.
> 
> Ralf,
> I request you to drop already submitted patches for NAND device nodes.
> It is merge conflicts with this patches.
> http://patchwork.linux-mips.org/patch/10577/
> http://patchwork.linux-mips.org/patch/10578/
> http://patchwork.linux-mips.org/patch/10579/
> http://patchwork.linux-mips.org/patch/10580/
> 
> Jaedon Shin (10):
>   ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
>   ata: ahch_brcmstb: add data for port offset
>   ata: ahci_brcmstb: add support 40nm platforms

ata part looks fine to me.  Let me know when the other parts get in.
I'll apply the ata ones to libata/for-4.4.

Thanks.

-- 
tejun
