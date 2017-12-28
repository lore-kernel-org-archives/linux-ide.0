From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH] sata: rcar_sata: Reset SATA PHY when Salvator-X board resumes
Date: Fri, 29 Dec 2017 07:16:59 +0900
Message-ID: <CAH1o70JKbgACP7GG9Z=eoHx684bp48FLqvUoFEzQMPy=4RdRPA@mail.gmail.com>
References: <1512585925-4251-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdXXa5pA7eXrmEamKXY_v8t2LKSq7bA6ysH5S2Pqq-b5aA@mail.gmail.com> <20171219082649.47jp3dwuuopel5rk@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:42167 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdL1WRA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Dec 2017 17:17:00 -0500
In-Reply-To: <20171219082649.47jp3dwuuopel5rk@verge.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Simon-san, Geert-san,

2017-12-19 17:26 GMT+09:00 Simon Horman <horms@verge.net.au>:
> On Wed, Dec 06, 2017 at 07:56:09PM +0100, Geert Uytterhoeven wrote:
>> Hi Kaneko-san,
>>
>> On Wed, Dec 6, 2017 at 7:45 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> > From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
>> >
>> > Because power of Salvator-X board is cut off in suspend,
>> > it needs to reset SATA PHY state in resume.
>> > Otherwise, SATA partition could not be accessed anymore.
>>
>> Thanks for your patch!
>>
>> So this is needed on R-Car Gen3 only.
>>
>> > --- a/drivers/ata/sata_rcar.c
>> > +++ b/drivers/ata/sata_rcar.c
>> > @@ -977,11 +977,43 @@ static int sata_rcar_resume(struct device *dev)
>> >         struct sata_rcar_priv *priv = host->private_data;
>> >         void __iomem *base = priv->base;
>> >         int ret;
>> > +       u32 val;
>> >
>> >         ret = clk_prepare_enable(priv->clk);
>> >         if (ret)
>> >                 return ret;
>> >
>> > +       /* Re-use from sata_rcar_init_controller() */
>> > +       /* reset and setup phy */
>> > +       switch (priv->type) {
>> > +       case RCAR_GEN1_SATA:
>> > +               sata_rcar_gen1_phy_init(priv);
>>
>> Hence why do this (and the below) on R-Car Gen1, too?
>>
>> > +               break;
>> > +       case RCAR_GEN2_SATA:
>> > +               sata_rcar_gen2_phy_init(priv);
>>
>> And on both R-Car Gen2 and Gen3 (currently Gen3 is treated like Gen2
>> everywhere in the driver)?
>> What about introducing RCAR_GEN3_SATA, and doing the reinit on R-Car Gen3
>> only?
>
> Agreed, that seems to make sense.
> Kaneko-san, could you look into implementing this?

Yes, I will do it.

Kaneko

>
>>
>> > +               break;
>> > +       default:
>> > +               dev_warn(host->dev, "SATA phy is not initialized\n");
>> > +               break;
>> > +       }
>>
>> [...]
>>
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a hacker. But
>> when I'm talking to journalists I just say "programmer" or something like that.
>>                                 -- Linus Torvalds
>>
