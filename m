From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_rcar: add gen[23] fallback compatibility
 strings
Date: Sat, 15 Jul 2017 07:09:10 -0400
Message-ID: <20170715110909.GF2969123@devbig577.frc2.facebook.com>
References: <1499773460-8930-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1499773460-8930-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-ide@vger.kernel.org

On Tue, Jul 11, 2017 at 01:44:20PM +0200, Simon Horman wrote:
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

Applied to libata/for-4.13-fixes.

Thanks.

-- 
tejun
