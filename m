From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 2/2] sata_rcar: Document deprecated "renesas,rcar-sata"
Date: Fri, 14 Nov 2014 12:36:39 -0500
Message-ID: <20141114173639.GF25889@htj.dyndns.org>
References: <1415644950-2983-1-git-send-email-geert+renesas@glider.be>
 <1415644950-2983-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415644950-2983-2-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Nov 10, 2014 at 07:42:30PM +0100, Geert Uytterhoeven wrote:
> Commit e67adb4e669db834 ("sata_rcar: Add R-Car Gen2 SATA PHY support")
> deprecated "renesas,rcar-sata" in favor of "renesas,sata-r8a7779", but
> the deprecated value was never documented in the binding documentation,
> while it is still in active use.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Applied to libata/for-3.19.

Thanks.

-- 
tejun
