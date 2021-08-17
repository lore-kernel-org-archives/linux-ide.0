Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FB5C4338F
	for <linux-ide@archiver.kernel.org>; Tue, 17 Aug 2021 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51ED60F11
	for <linux-ide@archiver.kernel.org>; Tue, 17 Aug 2021 18:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhHQSCP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:02:15 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhHQSCO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2021 14:02:14 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N2E9Y-1nDl1Q38zW-013aYU; Tue, 17 Aug 2021 20:01:22 +0200
Date:   Tue, 17 Aug 2021 20:01:21 +0200
From:   Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic
 cases.
Message-ID: <YRv5cafgitLlfiCs@reimardoeffinger.de>
References: <YRjN4oULwmNKI/yi@infradead.org>
 <20210815162725.15124-1-Reimar.Doeffinger@gmx.de>
 <DM6PR04MB708117F3FD8537CB6875E2C4E7FD9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <YRqfxrWJsIeyjFed@reimardoeffinger.de>
 <DM6PR04MB708170BD5DC19ABC03FDC4A3E7FE9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR04MB708170BD5DC19ABC03FDC4A3E7FE9@DM6PR04MB7081.namprd04.prod.outlook.com>
X-Provags-ID: V03:K1:Uk6sYorosuKx7xgggVkqArO0nYJNfNPJQoAazy7kjTMhsp3k3sw
 noI7IQyTcp+TNZCzHghHJckPVAi7LPcMFRwtvpB0JH2hOVVkkfEfo3KgbHyatoxKwzneVa8
 k0Lv4w4PD/oi1MuUDzWqCnB/9wedGpSVL0FvRPsoo9+P0amOkazRGXIwbOmFESV5TpntnYE
 5EwdysDczLJ6nptmTzz8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d1c7f3mxFfg=:w8OuUkex/zE+32Zo+85y7J
 K7oGKTaLZPvEn4yofZA/Y16ZfCifESJAtF5F/dgNWwsaLOxJJZE+8Qo9ib6QxRi5P/dZ+CJM2
 LmGaEM/Dhgn8ia8sNJg7E41jJjfdV89MLzvto9+CFIvCAFdJpGpahrGB5tI81ia/XV/NDPEjF
 31YMbpFjUGaMoWwYeSiXxo0vxZTAqrQs+ZMo/OaT0e9gV3N6K4Eu/5FTEnJOCJ7QDIA9I/8Us
 DWVD7xXzjUk+gxzGDfg+q4HlJ6e+p0zuKw1GQPmuTYHu5HerKWFoGB21gmxn7YQ91/ZP6HlyX
 HpP+WrkpU2WpVRllY/DTpE0AWxieQnDBWqRFuT9RZJccZZWckhM+sPdiRSZAfnFp1i6etb8ZH
 sGCjdTDF2Sg/GZUMsUDXgo80IpH0jPe2CXDR33MrhS6zcrj4w2f/DCA8t8S1B8QA5gOcGrSv5
 DOxVh0OR/yGwLzmwW1NjNAEbEEBzOpTwnwTu/Z7NAWYy2h302ZLpCB7s718UFjiVfSnZdG++G
 zVKR9q4QnEpFaM1zg0AHNO8k4Sd+GeRlDbqUitWdI/Uc59jpJeACPGyCGCUruLZgp3ov5CzLU
 m08M7GwrTVNrpmqDyBxPje1mejpAs57KJ84cz+qLD02O4wtwDLxlrZgygkI5J+TjZ/N1k8Wa0
 H9BesO8rsb6+tPrimAzKKvI2gB25HhIJd8XGrjG34lkASRzZ8EPAceyS284ptZ/3NuBFIHznJ
 waxs9OfBxcqI/TNMWfECKOdYsxidOQDIg8uXLqgzSdDGFiOAVVaYQiLXzhO5IPZISQpGLcMOe
 q9282BqhidAmcX1/ZwD+FYYODniV7QgTvE9/3NCtotaJ4Ep3EhyuYIn9wYbstRkCVlWY/TQup
 jlldcWwdENt+omU/gxZg==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Aug 17, 2021 at 07:45:58AM +0000, Damien Le Moal wrote:
> On 2021/08/17 2:26, Reimar Döffinger wrote:
> > The patch is a best-guess + "in doubt disable" attempt at
> > auto-detecting.
> > As I mentioned the data is rather light, so I wanted to only add the
> > option at first.
> > Now it does 2 things in addition:
> > - disable it for Crucial MX500 because the issue was seen and confirmed
> >   with and without PATA converter with that device
> > - disable it for anything connected with a PATA converter because there
> >   are lots of bug reports with different devices that have a PATA
> >   converter in common. Unfortunately no confirmation from any of those.
> >   However in quick testing I could verify the MX500 issue only with
> >   PATA adapter myself, so it seems like an appropriate precaution,
> >   especially as now with the new code it is possible to override both
> >   ways.
> 
> How can you detect the presence of a PATA converter ? Is it what "ap_flags &
> ATA_FLAG_SATA" indicates ?

Well, if my understanding is right when ATA_FLAG_SATA is not set then
it means it is a PATA controller.
So if someone has a PATA device that supports READ_LOG_DMA then it
would be disabled even in that case, but I had the impression
that command is new enough for this to be not very likely (and
I am guessing most PATA users care more about things working
than getting the best possible performance).


> > Aside: I don't have the ATA spec, so I can't check, but I do find it
> > a bit suspicious that the logs look like the code runs the
> > READ_LOG_DMA command before SETXFERMODE is done, and thus while the
> > device is still in PIO mode?

This is a bit off-topic for the patch, so you can leave me to try and
figure it out myself, but I am afraid your explanation does not quite
add up to me:

> ata_read_log_page() has a retry loop: it first tries ATA_CMD_READ_LOG_DMA_EXT
> and if that fails, it goes with PIO ATA_CMD_READ_LOG_EXT. So there is no problem
> for non-buggy drives with this. Note that initially, dev->dma_mode may not be
> set, so PIO is done directly.

Hm, I see that might have been the intent, but that does not seem to be
the case.
The condition is:
> if (dev->dma_mode &&
However the correct way to check is to use ata_dma_enabled.
Which is:
return (adev->dma_mode == 0xFF ? 0 : 1);
So kind of the opposite (actually I think dev->dma_mode is always true),
and matching that ata_bus_probe sets dev->dma_mode = 0xff;
Now ata_do_set_mode would set up the proper value, but the little
problem is that that one is never called for SATA (and quite a few
PATA?) controllers.
So it seems there is no working way to detect if dma is enabled or not?
Unless the initialization value after reset would need to depend on
the controller, setting it to 0xff for no dma for PATA and some "random"
UDMA setting (or a newly added DMA_SATA one) for SATA controllers?

> Once set, DMA version will be used unless the
> horkage bit is set. So this all works as expected, and there will (normally) be
> no failed command even when DMA is not yet set.

A typical log looks as below, now I admit it is very confusing because
it says the mode is 6.0 Gbps which is not even possible with PATA,
so not really clear which mode is active at which point.
However I think that DMA is only properly up after ata_do_set_mode (however
that is not used at all by most controllers it seems?), which
is the "failed to set xfermode", however that is long after the
"READ LOG DMA EXT failed".

[    1.245078] ata5: SATA max UDMA/133 abar m2048@0xc161b000 port 0xc161b300 irq 28
[    1.557761] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.557929] ata5.00: FORCE: horkage modified (noncq)
[    1.558096] ata5.00: ACPI cmd ef/10:09:00:00:00:b0 (SET FEATURES) succeeded
[    1.558101] ata5.00: ACPI cmd ef/10:03:00:00:00:b0 (SET FEATURES) filtered out
[    1.558250] ata5.00: ATA-10: Lenovo SPEED UP-CL-240GB, V2.7, max UDMA/133
[    1.558253] ata5.00: 468862128 sectors, multi 0: LBA48 NCQ (not used)
[    6.663379] ata5.00: qc timeout (cmd 0x47)
[    6.663390] ata5.00: READ LOG DMA EXT failed, trying PIO
[    6.663394] ata5.00: failed to get Identify Device Data, Emask 0x40
[    6.663407] ata5.00: failed to set xfermode (err_mask=0x40)
[    6.977799] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

