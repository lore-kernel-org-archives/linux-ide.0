From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] pata: imx: add support of setting timings for PIO
 modes
Date: Thu, 10 Nov 2016 11:10:39 -0500
Message-ID: <20161110161039.GA26105@htj.duckdns.org>
References: <20161109005638.17691-1-vz@mleia.com>
 <20161109005638.17691-4-vz@mleia.com>
 <23fb0678-db2a-a0ff-65a3-3174720b0ee8@cogentembedded.com>
 <ed9bacd7-b6f4-811b-c082-ae4235a747c6@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36546 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934685AbcKJQKm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2016 11:10:42 -0500
Received: by mail-yb0-f194.google.com with SMTP id d128so5159586ybh.3
        for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2016 08:10:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ed9bacd7-b6f4-811b-c082-ae4235a747c6@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

Hello, Vladimir, Sergei.

On Thu, Nov 10, 2016 at 03:33:22AM +0200, Vladimir Zapolskiy wrote:
> thank you for review, I see that Tejun has applied the changes,
> anyway I'll answer your questions.

Oh, please submit incremental patches as necessary.

> > > @@ -31,6 +40,10 @@
> > >  #define PATA_IMX_DRIVE_DATA        0xA0
> > >  #define PATA_IMX_DRIVE_CONTROL        0xD8
> > > 
> > > +static u32 pio_t4[] = { 30,  20,  15,  10,  10 };
> > > +static u32 pio_t9[] = { 20,  15,  10,  10,  10 };
> > > +static u32 pio_tA[] = { 35,  35,  35,  35,  35 };
> > 
> >    Perhaps it makes sense to extend the 'struct ata_timing'...
> > 
> > [...]
> 
> As you guess the numbers are taken right from the ATAPI spec,
> however I haven't found the second ATA controller driver sumbitted
> upstream, which reuses these timings, so probably generalization
> is not needed here. Anyway I would prefer if maintainers do it,
> if they think that it makes sense.

Given that its usage isn't likely to be further expanded, I don't
think it matters that much either way, but it does make sense to put
them in ata_timing.  I'd be happy to apply such a patch.

> >    What do those registers mean?
> 
> You may find a better description from i.MX27 or i.MX31 Reference Manual
> than my retelling, the docs are open.
> 
> toff/ton timings are used to avoid bus contention when switching
> BUFFER_EN signal and data writing period. AFAIK these timings are
> specific to the controller only.
> 
> > > +    writeb(timing.setup, priv->host_regs + PATA_IMX_ATA_TIME_1);
> > > +    writeb(timing.act8b, priv->host_regs + PATA_IMX_ATA_TIME_2W);
> > > +    writeb(timing.act8b, priv->host_regs + PATA_IMX_ATA_TIME_2R);
> > > +    writeb(1, priv->host_regs + PATA_IMX_ATA_TIME_PIO_RDX);
> > 
> >    And this one?
> 
> This is trd timing from the ATA/ATAPI spec, "Read Data Valid to IORDY
> active", its minimal value is defined as 0.

Add comments for these explanations maybe?

> > > +
> > > +    writeb(pio_t4[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_4);
> > > +    writeb(pio_t9[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_9);
> > > +    writeb(pio_tA[mode] / T + 1, priv->host_regs +
> > > PATA_IMX_ATA_TIME_AX);
> > 
> >    DIV_ROUND_UP(x, T)?
> 
> Yes, it is reasonable.

And also for this cleanup?

Thanks.

-- 
tejun
