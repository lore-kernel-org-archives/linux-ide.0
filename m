From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc5 2/2] sata_promise: SATA hotplug support
Date: Tue, 03 Jul 2007 15:47:39 +0900
Message-ID: <4689F10B.8090606@gmail.com>
References: <200706191954.l5JJsVl9002671@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:45832 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbXGCGro (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 02:47:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2643800wah
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 23:47:44 -0700 (PDT)
In-Reply-To: <200706191954.l5JJsVl9002671@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch enables hotplugging of SATA devices in the
> sata_promise driver. It's been tested successfully on
> both first- and second-generation Promise SATA chips:
> SATA150 TX2plus, SATAII150 TX2plus, SATA300 TX2plus,
> and SATA300 TX4.
> 
> The only quirk I've seen is that hotplugging (insertion)
> on the first-generation SATA150 TX2plus requires a lengthier
> EH sequence than on the second-generation chips.
> On the second-generation chips a simple soft reset seems
> to suffice, but on the first-generation chip there's a
> "port is slow to respond" after the initial soft reset,
> after which libata issues a hard reset, and then the
> device is recognised.
> 
> The hotplug checks are high up in the interrupt handling
> path, not deep down in error_intr as in ahci/sata_sil24.
> That's because the chip doesn't signal hotplug status changes
> in the per-port status register: instead a global register
> contains hotplug control and status flags for all ports.
> I considered following the ahci/sata_sil24 structure, but
> that would have required non-trivial changes to the interrupt
> handling path, so I chose to keep the hotplug changes simple
> and unobtrusive.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Some unlikely()'s might be helpful here and there but other than that.

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
