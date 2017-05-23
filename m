From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4 v2] ata: Add driver for Faraday Technology FTIDE010
Date: Tue, 23 May 2017 17:25:56 -0400
Message-ID: <20170523212556.GK13222@htj.duckdns.org>
References: <20170519230600.16782-1-linus.walleij@linaro.org>
 <20170519230600.16782-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32991 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034108AbdEWVZ7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2017 17:25:59 -0400
Received: by mail-yw0-f195.google.com with SMTP id y64so10275727ywe.0
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2017 14:25:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170519230600.16782-3-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, John Feng-Hsin Chiang <john453@faraday-tech.com>, Greentime Hu <green.hu@gmail.com>

Hello,

On Sat, May 20, 2017 at 01:05:59AM +0200, Linus Walleij wrote:
> This adds a driver for the Faraday Technology FTIDE010
> PATA IP block.
> 
> When used with the Storlink/Storm/Cortina Systems Gemini
> SoC, the PATA interface is accompanied by a PATA<->SATA
> bridge, so while the device appear as a PATA controller,
> it attaches physically to SATA disks, and also has a
> designated memory area with registers to set up the bridge.
> 
> The Gemini SATA bridge is separated into its own driver
> file to make things modular and make it possible to reuse
> the PATA driver as stand-alone on other systems than the
> Gemini.
> 
> dmesg excerpt from the D-Link DIR-685 storage router:
> gemini-sata-bridge 46000000.sata: SATA ID 00000e00, PHY ID: 01000100
> gemini-sata-bridge 46000000.sata: set up the Gemini IDE/SATA nexus
> ftide010 63000000.ata: set up Gemini PATA0
> ftide010 63000000.ata: device ID 00000500, irq 26, io base 0x63000000
> ftide010 63000000.ata: SATA0 (master) start
> gemini-sata-bridge 46000000.sata: SATA0 PHY ready
> scsi host0: pata-ftide010
> ata1: PATA max UDMA/133 irq 26
> ata1.00: ATA-8: INTEL SSDSA2CW120G3, 4PC10302, max UDMA/133
> ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 0/32)
> ata1.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSA2CW12 0302 PQ: 0 ANSI: 5
> ata1.00: Enabling discard_zeroes_data
> sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: enabled, read cache:
>                   enabled, doesn't support DPO or FUA
> ata1.00: Enabling discard_zeroes_data
> ata1.00: Enabling discard_zeroes_data
> sd 0:0:0:0: [sda] Attached SCSI disk
> 
> After this I can flawlessly mount and read/write copy etc files
> from /dev/sda[n].

Heh, that's a lot of driver.  Looks okay to me but, Bart, can you
please review and ack this one?

Thanks.

-- 
tejun
