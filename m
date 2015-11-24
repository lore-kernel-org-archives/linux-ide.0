From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_rcar: Remove obsolete platform_device_id
 entries
Date: Tue, 24 Nov 2015 09:55:34 -0500
Message-ID: <20151124145534.GE17033@mtj.duckdns.org>
References: <1448376304-8304-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448376304-8304-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-ide@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Nov 24, 2015 at 03:45:04PM +0100, Geert Uytterhoeven wrote:
> Since commit c99cd90d98a98aa1 ("ARM: shmobile: r8a7779: Remove legacy
> SoC code"), R-Car SoCs are only supported in generic DT-only ARM
> multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the remaining platform_device_id
> entries and platform device support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Applied to libata/for-4.5.

Thanks.

-- 
tejun
