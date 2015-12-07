From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: core: fix irq description on AHCI single irq systems
Date: Mon, 7 Dec 2015 14:00:20 +0300
Message-ID: <566566C4.500@cogentembedded.com>
References: <5664A101.1050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36548 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333AbbLGLAZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2015 06:00:25 -0500
Received: by lbblt2 with SMTP id lt2so58318001lbb.3
        for <linux-ide@vger.kernel.org>; Mon, 07 Dec 2015 03:00:24 -0800 (PST)
In-Reply-To: <5664A101.1050401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hello.

On 12/06/2015 11:56 PM, Heiner Kallweit wrote:

> On my machine with single irq AHCI just the PCI id is printed as
> description in /proc/interrupts.
> I found a related discussion from beginning of this year:
> http://www.gossamer-threads.com/lists/linux/kernel/2117335
>
> Seems like commit commit 4f37b504768c952b64bc9469a2d579c7597590f2
                     ^^^^^^ one is enough :-)

    And scripts/checkpatch.pl now rnofrces certain format for the commit citing.

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

    s/ide/sata/?

> Using managed memory allocation ensures that the irq description
> lives at least as long as the interrupt.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

[...]

MBR, Sergei

