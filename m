From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] ata: sata_rcar: add gen[23] fallback compatibility strings
Date: Fri, 25 Mar 2016 08:49:29 +0100
Message-ID: <CAMuHMdX+bNRxNweSfJRm+FX+_KQSD_Q++BcegmLULSVL7kpM-A@mail.gmail.com>
References: <1458871280-19330-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1458871280-19330-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Mar 25, 2016 at 3:01 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add fallback compatibility string for R-Car Gen 2 and 3.
>
> In the case of Renesas R-Car hardware we know that there are generations of
> SoCs, e.g. Gen 1 and 2. But beyond that its not clear what the relationship
> between IP blocks might be. For example, I believe that r8a7790 is older
> than r8a7791 but that doesn't imply that the latter is a descendant of the
> former or vice versa.
>
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appears
> to be compatible with the IP blocks on SoCs within a given generation.
>
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme being adopted for
> drivers for Renesas SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
