From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] ata: Add DT bindings for Faraday Technology FTIDE010
Date: Fri, 12 May 2017 10:24:52 -0500
Message-ID: <20170512152452.jps5akmsxuvovugy@rob-hp-laptop>
References: <20170506121053.11554-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170506121053.11554-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Janos Laube <janos.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paulius Zaleckas <paulius.zaleckas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, openwrt-devel-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hans Ulli Kroll <ulli.kroll-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Feng-Hsin Chiang <john453-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Sat, May 06, 2017 at 02:10:50PM +0200, Linus Walleij wrote:
> This adds device tree bindings for the Faraday Technology
> FTIDE010 found in the Storlink/Storm/Cortina Systems Gemini SoC.
> 
> I am not 100% sure that this part if from Faraday Technology but

s/if/is/

> a lot points in that direction:
> 
> - A later IDE interface called FTIDE020 exist and share some
>   properties.
> 
> - The SATA bridge has the same Built In Self Test (BIST) that the
>   Faraday FTSATA100 seems to have, and it has version number 0100
>   in the device ID register, so this is very likely a FTSATA100
>   bundled with the FTIDE010.
> 
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: John Feng-Hsin Chiang <john453-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>
> Cc: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> Greentime: I think this may be interesting to you since the
> FTIDE020 will need the same bindings so we can probably
> just reuse them and maybe make the parser a library if you
> want to upstream the FTIDE020.
> 
> Faraday people: I do not have it from a source that this
> hardware is really FTIDE010 but I would be VERY surprised
> if it is not. U-Boot has an FTIDE020 IDE controller
> synthesized in the Andestech platform, and it has a similar
> yet different register layout, featuring similar timing
> set-ups:
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/block/ftide020.h
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/block/ftide020.c
> ---
>  .../devicetree/bindings/ata/faraday,ftide010.txt   | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.txt

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
