From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ata: sata_rcar: add gen[123] fallback compatibility
 strings
Date: Wed, 9 Mar 2016 11:24:23 +0900
Message-ID: <20160309022420.GA4986@verge.net.au>
References: <1457400642-19377-1-git-send-email-horms+renesas@verge.net.au>
 <20160308013312.GA19565@verge.net.au>
 <CAMuHMdXeU3UfLe7nFV3PHksJKvUzUbn0tifAZBNcrxzgXmiEcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXeU3UfLe7nFV3PHksJKvUzUbn0tifAZBNcrxzgXmiEcA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 08, 2016 at 09:37:24AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Mar 8, 2016 at 2:33 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Mar 08, 2016 at 10:30:42AM +0900, Simon Horman wrote:
> >> Add fallback compatibility string for R-Car Gen 1, 2 and 3.
> >>
> >> In the case of Renesas R-Car hardware we know that there are generations of
> >> SoCs, e.g. Gen 1 and 2. But beyond that its not clear what the relationship
> >> between IP blocks might be. For example, I believe that r8a7779 is older
> >> than r8a7778 but that doesn't imply that the latter is a descendant of the
> >> former or vice versa.
> >>
> >> We can, however, by examining the documentation and behaviour of the
> >> hardware at run-time observe that the current driver implementation appears
> >> to be compatible with the IP blocks on SoCs within a given generation.
> >>
> >> For the above reasons and convenience when enabling new SoCs a
> >> per-generation fallback compatibility string scheme being adopted for
> >> drivers for Renesas SoCs.
> >>
> >> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >> ---
> >> Based on libata/for-next
> >> ---
> >>  Documentation/devicetree/bindings/ata/sata_rcar.txt | 15 ++++++++++++---
> >>  drivers/ata/sata_rcar.c                             | 12 ++++++++++++
> >>  2 files changed, 24 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >> index 0764f9ab63dc..b44048176938 100644
> >> --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >> @@ -1,14 +1,23 @@
> >>  * Renesas R-Car SATA
> >>
> >>  Required properties:
> >> -- compatible         : should contain one of the following:
> >> +- compatible         : should contain one or more of the following:
> >>                         - "renesas,sata-r8a7779" for R-Car H1
> >> -                         ("renesas,rcar-sata" is deprecated)
> >>                         - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
> >>                         - "renesas,sata-r8a7790" for R-Car H2 other than ES1
> >>                         - "renesas,sata-r8a7791" for R-Car M2-W
> >>                         - "renesas,sata-r8a7793" for R-Car M2-N
> >>                         - "renesas,sata-r8a7795" for R-Car H3
> >> +                       - "renesas,rcar-gen1-sata" for a generic R-Car Gen1 compatible device
> 
> Given R-Car H1 is the only member of the R-Car Gen1 family that has SATA
> (both M1A and E1 don't seem to have it), do we want to support
> "renesas,rcar-gen1-sata" in the bindings...

I added it mainly for consistency. I'm happy to drop it if you like.

> >> +                       - "renesas,rcar-gen2-sata" for a generic R-Car Gen2 compatible device
> >> +                       - "renesas,rcar-gen3-sata" for a generic R-Car Gen3 compatible device
> >> +                       - "renesas,rcar-sata" is deprecated
> 
> >> --- a/drivers/ata/sata_rcar.c
> >> +++ b/drivers/ata/sata_rcar.c
> >> @@ -858,6 +858,18 @@ static struct of_device_id sata_rcar_match[] = {
> >>               .compatible = "renesas,sata-r8a7795",
> >>               .data = (void *)RCAR_GEN2_SATA
> >>       },
> >> +     {
> >> +             .compatible = "renesas,rcar-gen1-sata",
> >> +             .data = (void *)RCAR_GEN1_SATA
> >> +     },
> 
> ... and in the driver?
> It already matches on (deprecated) "renesas,rcar-sata" and
> "renesas,sata-r8a7779"?
> 
> >> +     {
> >> +             .compatible = "renesas,rcar-gen2-sata",
> >> +             .data = (void *)RCAR_GEN2_SATA
> >> +     },
> >> +     {
> >> +             .compatible = "renesas,rcar-gen3-sata",
> >> +             .data = (void *)RCAR_GEN2_SATA
> >> +     },
> >>       { },
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
