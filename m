From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: core: fix irq description on AHCI single irq systems
Date: Mon, 7 Dec 2015 09:48:06 -0500
Message-ID: <20151207144806.GA9175@mtj.duckdns.org>
References: <5664A101.1050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33083 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196AbbLGOsJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2015 09:48:09 -0500
Received: by ykdv3 with SMTP id v3so196433285ykd.0
        for <linux-ide@vger.kernel.org>; Mon, 07 Dec 2015 06:48:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5664A101.1050401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Dec 06, 2015 at 09:56:33PM +0100, Heiner Kallweit wrote:
> On my machine with single irq AHCI just the PCI id is printed as
> description in /proc/interrupts.
> I found a related discussion from beginning of this year:
> http://www.gossamer-threads.com/lists/linux/kernel/2117335
> 
> Seems like commit commit 4f37b504768c952b64bc9469a2d579c7597590f2
> tried to fix displaying a proper interrupt description for one
> scenario but broke it for another one.
> 
> The mentioned discussion ended in the current situation being
> considered as broken but w/o a patch to fix it.
> 
> The following patch is based on a proposal in this mail thread.
> Now the interrupt is properly described as:
> PCI-MSI 512000-edge      ahci[0000:00:1f.2]
> 
> By combining both values also the scenario that commit
> 4f37b504768c952b64bc9469a2d579c7597590f2 refers to should
> still be fine. There it should look like this now:
> ahci[20100000.ide]
> 
> Using managed memory allocation ensures that the irq description
> lives at least as long as the interrupt.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to libata/for-4.5 w/ commit refs fixed.

Thanks.

-- 
tejun
