From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 3/4 v4] ata: Add driver for Faraday Technology FTIDE010
Date: Mon, 12 Jun 2017 17:54:40 +0200
Message-ID: <2693110.AQhD5I4g7H@amdc3058>
References: <20170604085009.11902-1-linus.walleij@linaro.org>
 <CGME20170604085035epcas3p42ba2630fc743acafb65a2b501696c66d@epcas3p4.samsung.com>
 <20170604085009.11902-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20170604085009.11902-3-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, John Feng-Hsin Chiang <john453@faraday-tech.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, linux-ide@vger.kernel.org, Greentime Hu <green.hu@gmail.com>, Tejun Heo <tj@kernel.org>, Janos Laube <janos.dev@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Sunday, June 04, 2017 10:50:08 AM Linus Walleij wrote:
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
> 
> Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks for fixing it.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
