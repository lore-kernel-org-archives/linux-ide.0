From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4 v3] ata: Add driver for Faraday Technology FTIDE010
Date: Sun, 4 Jun 2017 10:39:07 +0200
Message-ID: <CACRpkdb1WNDk-zavUfLZvDMXFsnyqZOuzCsqM1C1S7DOL0kQKA@mail.gmail.com>
References: <20170530113402.20450-1-linus.walleij@linaro.org>
 <CGME20170530113419epcas3p262d14182b61d8a3853ef0f962f6a1fb2@epcas3p2.samsung.com>
 <20170530113402.20450-3-linus.walleij@linaro.org> <1937268.BD9NpZS46X@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37186 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdFDIjK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 4 Jun 2017 04:39:10 -0400
Received: by mail-it0-f46.google.com with SMTP id m47so51700678iti.0
        for <linux-ide@vger.kernel.org>; Sun, 04 Jun 2017 01:39:10 -0700 (PDT)
In-Reply-To: <1937268.BD9NpZS46X@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, John Feng-Hsin Chiang <john453@faraday-tech.com>, Greentime Hu <green.hu@gmail.com>

Hi Barlomiej,

thanks a *lot* for detailed review and for showing me some really
tricky corners of ATA support!

Most things I just fixed, will send v4 soon.

On Tue, May 30, 2017 at 4:31 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

>> +static const bool set_mdma_66_mhz[] = { true, true, true, true };
>
> 50 MHz MWDMA timings are never used by the driver and can be removed..

I think it's nice to keep around as documentation really, and someone may want
to patch it in and experiment with 50MHz mode if things are not
working for them.

> CLK_MOD_REG is shared between master and slave so the driver needs to
> make sure that right clock is used if master and slave devices require
> different clocks (i.e. master is using UDMA5 and slave is using UDMA6).
(...)
> Moreover MWDMA_TIMING_REG is also shared between devices.
(...)
> ->qc_issue method can be used to program the right tuning values, i.e.

Wow thanks a lot for clearing this up!

I was a bit confused about how to deal with this. Now it makes a
lot more sense!

> static unsigned int ftide010_qc_issue(struct ata_queued_cmd *qc)
> {
>         struct ata_port *ap = qc->ap;
>         struct ata_device *adev = qc->dev;
>
>         if (adev != ap->private_data && ata_dma_enabled(adev))
>                 ftide010_set_dmamode(ap, adev);
>
>         return ata_bmdma_qc_issue(qc);
> }
>
> [ set ap->private_data to adev at the end of ftide010_set_dmamode() ]

I implemented this exactly as above, with some extra comments
so it's clear what is going on.

>> +static int pata_ftide010_gemini_cable_detect(struct ata_port *ap)
>> +{
>> +     struct ftide010 *ftide = ap->host->private_data;
>> +
>> +     /*
>> +      * Return the master cable, I have no clue how to return a different
>> +      * cable for the slave than for the master.
>> +      */
>
> Seems like ->cable_detect needs to operate on ata_device * now?
>
> Tejun?

Yeah... it looks like something libata is not really made to handle.

This platform has one IRQ for each port bridge anyways.

>> +             case GEMINI_MUXMODE_3:
>> +                     ftide->master_cbl = ATA_CBL_PATA40;
>> +                     ftide->slave_cbl = ATA_CBL_PATA40;
>> +                     break;
>> +             }
>
> It seems that for PATA devices 80-wires cable will be never
> used, is this correct?

That is a simplification. I haven't seen any systems using the
PATA interface at all.

I have put in some comments that we assume the
40-wire interface, and if something else like 80-wire is in use
then that needs to be specified in the device tree since the
SoC and driver cannot detect it without special hardware.

I guess I could add DT properties for it but it seems a bit
speculative since I can't test it.

Yours,
Linus Walleij
