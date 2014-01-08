From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 2/3] ata: ahci_platform: Manage SATA PHY
Date: Wed, 08 Jan 2014 11:05:07 +0100
Message-ID: <6214646.nAF6lzWV79@wuerfel>
References: <1389174428-31414-1-git-send-email-rogerq@ti.com> <1389174428-31414-3-git-send-email-rogerq@ti.com> <52CD2176.6050102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52CD2176.6050102-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Wednesday 08 January 2014 15:29:18 Kishon Vijay Abraham I wrote:
> > +     hpriv->phy = devm_phy_get(dev, "sata-phy");
> > +     if (IS_ERR(hpriv->phy)) {
> > +             dev_dbg(dev, "can't get sata-phy\n");
> > +             /* return only if -EPROBE_DEFER */
> > +             if (PTR_ERR(hpriv->phy) == -EPROBE_DEFER) {
> > +                     rc = -EPROBE_DEFER;
> > +                     goto disable_unprepare_clk;
> > +             }
> > +     }

This should probably check for all errors except "not present"
rather than checking for -EPROBE_DEFER. We want to abort the
probe function for deferred probe as well as the case where we
a PHY was listed but isn't working properly.

> > +     if (!IS_ERR(hpriv->phy)) {
> > +             phy_init(hpriv->phy);
> 
> Don't we have to check the return values of phy_init and phy_power_on? Is it
> not needed because it is an optional phy?

Right. I think we should set hpriv->phy to NULL if it's not there and
then call the functions only if it's actually present but bail out on
an error.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
