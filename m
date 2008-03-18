From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Tue, 18 Mar 2008 16:36:19 +0900
Message-ID: <47DF70F3.9080305@gmail.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <47D5320E.8020107@gmail.com> <200803170816.50597.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:23445 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYCRHg0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Mar 2008 03:36:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so6798406wah.23
        for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2008 00:36:25 -0700 (PDT)
In-Reply-To: <200803170816.50597.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

Volker Armin Hemmann wrote:
> I tried some more stuff, replaced the cables, played with bios settings.
> 
> No change.
> 
> Then I updated to 2.6.24.3 - and no hangs or 'softreset' failures anymore.

I don't see any libata changes which can cause such difference.  Weird.
 Is this result reliably reproducible?

> The only change to other kernels was making ehci-hcd modular. 

Hmmm...

> I checked already, other kernels still have the IDENTITY error on coldboot and 
> the softreset failure on reboot even with the changed config.

Hmmm...

> 2.6.24.2 and 2.6.24.3 both have the reiser4 patch added.
> 
> So
> 2.6.24.2 = bad
> 2.6.24.3 = good
> 2.6.25-rc5 = bad 
> 
> Setting AHCI in bios still results in timeouts and harddisks not found.

Does pci=nomsi help?

-- 
tejun
