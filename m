From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: kernel 2.6.31.1 + Sil 3512 + WDC WD5000AAKS-00V1A0 = no NCQ and
 	UDMA5 instead of UDMA6
Date: Fri, 18 Dec 2009 13:51:49 -0600
Message-ID: <4B2BDD55.5090800@hardwarefreak.com>
References: <4B2A3D25.9030209@hardwarefreak.com> <4B2A720B.2040809@pobox.com>	 <4B2AE779.9060109@hardwarefreak.com> <4B2AF2C2.9010708@pobox.com>	 <4B2AFBDD.30601@hardwarefreak.com> <4B2AFF7B.4000007@gmail.com>	 <4B2B0642.3010501@hardwarefreak.com> <51f3faa70912172100p103e7698ne8a4216fe6471634@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:42635 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbZLRTvv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2009 14:51:51 -0500
In-Reply-To: <51f3faa70912172100p103e7698ne8a4216fe6471634@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Robert Hancock put forth on 12/17/2009 11:00 PM:
> On Thu, Dec 17, 2009 at 10:34 PM, Stan Hoeppner <stan@hardwarefreak.com> wrote:

>> So, how does this "phantom" UDMA setting affect either libata or
>> sata_sil?  If it effects nothing, why is it hanging around?  Is this a
>> backward compatibility thing for the kernel's benefit?  I'm not a kernel
>> hacker or programmer (yet), so please forgive my ignorant questions.
> 
> It doesn't affect either the driver or the controller. Only the drive
> may possibly care - that would be if there's a SATA-to-PATA bridge
> involved (as some early SATA drives had internally, for example) and
> there's an actual PATA bus that needs to be programmed properly for
> speed. Other than that, it's basically vestigial.

So in sata_sil.c version 2.4, the following are only present in the case
one of these early drives with an onboard PATA-SATA bridge is connected?

        SIL_QUIRK_UDMA5MAX      = (1 << 1),

} sil_blacklist [] = {

        { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },


static const struct ata_port_info sil_port_info[] = {
        /* sil_3512 */
        {
                .flags          = SIL_DFL_PORT_FLAGS |
SIL_FLAG_RERR_ON_DMA_ACT,
                .pio_mask       = ATA_PIO4,
                .mwdma_mask     = ATA_MWDMA2,
                .udma_mask      = ATA_UDMA5,
                .port_ops       = &sil_ops,
        },

 *      20040111 - Seagate drives affected by the Mod15Write bug are
blacklisted
 *      The Maxtor quirk is in the blacklist, but I'm keeping the original
 *      pessimistic fix for the following reasons...
 *      - There seems to be less info on it, only one device gleaned off the
 *      Windows driver, maybe only one is affected.  More info would be
greatly
 *      appreciated.
 *      - But then again UDMA5 is hardly anything to complain about

        /* limit to udma5 */
        if (quirks & SIL_QUIRK_UDMA5MAX) {
                if (print_info)
                        ata_dev_printk(dev, KERN_INFO, "applying Maxtor "
                                       "errata fix %s\n", model_num);
                dev->udma_mask &= ATA_UDMA5;
                return;
        }


Might it be beneficial, if merely to keep people like myself from asking
questions, to set the default for the 3512 to UDMA6 max instead of UDMA5
max, and only set UDMA5 in the case of a blacklisted Maxtor?  I'm sure
I'm not the first person to see in dmesg that my drive is showing
UDMA/133 capability but sata_sil is "limiting" the drive to UDMA/100.
If this setting is merely window dressing for all but the oldest borked
SATA1 drives with bridge chips, why not fix up this code so it at least
"appears" the controller is matching the mode the new pure SATA drive is
reporting?

> In my experience, you get a little bit more performance with hdparm,
> etc. with NCQ enabled. But that depends on the drive implementation a
> lot - if it's poorly optimized for NCQ you can see a slowdown.

So, not knowing whether my WD Blue has a good NCQ implementation or not,
it doesn't seem prudent to spend $40 on a new NCQ capable controller
card to get a few percent more performance from a $55 drive.  Agreed?

> It's true the biggest benefits tend to be with multithreaded
> workloads, but even single-threaded workloads can get broken down by
> the kernel into multiple parallel requests.

Noted.  Speaking of the kernel, why do I see 85MB/s using O_DIRECT with
hdparm, yet I only get 55MB/s with buffered reads?  On my workstation,
with a 4 year old 120GB Seagate IDE disk I get 32MB/s with both hdparm
test modes.  O_DIRECT gives no advantage on my workstation, but a 38%
advantage on the server.  The server with the SATA drive, the machine
we've been discussing the past few days, is a dual 550MHz CPU with PC100
memory bus, Intel BX chipset (circa 1998), and sil3512 PCI SATA card.
The workstation is an Athlon XP (32 bit) at 2GHz with nVidia nForce2
chipset, dual channel DDR2 400.  The server is running Debian 5.0.3 with
my custom 2.6.31.1 kernel built from kernel.org sources with make
menuconfig.  The workstation is running a stock SuSE Linux Enterprise
Desktop 10 kernel, though I can't recall what 2.6.x rev it is.  (I dual
boot winders and SLED and I'm in winders now)

Is the CPU/mem subsystem in the server the cause of the 38% drop in
buffered read performance vs O_DIRECT, or does my custom kernel need
some work somewhere?  Can someone point me to some docs that explain why
the buffer cache on this system is putting such a clamp on buffered
sequential disk reads in hdparm compared to raw performance?

Again, thanks for your help and patience.

--
Stan
