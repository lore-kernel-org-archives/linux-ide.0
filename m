From: Tejun Heo <tj@kernel.org>
Subject: Re: [Patch] enable AHCI mode on certain ich chipsets
Date: Thu, 17 Feb 2011 11:03:30 +0100
Message-ID: <20110217100330.GO19830@htj.dyndns.org>
References: <20110216090548.GQ5778@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37471 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab1BQKDg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2011 05:03:36 -0500
Received: by fxm20 with SMTP id 20so2405833fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2011 02:03:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110216090548.GQ5778@Redstar.dorchain.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joerg Dorchain <joerg@dorchain.net>
Cc: linux-ide@vger.kernel.org

On Wed, Feb 16, 2011 at 10:05:48AM +0100, Joerg Dorchain wrote:
> this patch allows to force ICH7/8/9 into AHCI mode.  This is needed
> because some BIOSes do not make AHCI-mode operation available to the
> user.
> As the Intel documentation states that the OS should not carry
> out the operation - the user must force this on the kernel
> commandline using quirk_ich_force_ahci
> 
> As this quirk gets called whilst the PCI subsystem is
> walking the PCI bus, we declare this quirk against the LPC
> (device 00:1f.0), so that we can frob 00:1f.2 before the PCI
> code has scanned it.
> Note: the pci id might change due to this (e.g. from 27c4 to 27c5)
> 
> For working suspend/resume, the next patch is required, too.

There have been multiple attempts at this and as Jeff pointed out ABAR
allocation usually is one of the technical roadblocks.

I'm not particularly inclined toward including this patch in upstream
as long as it can't be enabled by default.  It's just gonna be an
extra piece of code to carry around which only a handful of people use
and nobody really knows on which hardware it works or not and to what
extent.

Thanks.

-- 
tejun
