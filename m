From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_rcar: Remove unused variable in
 sata_rcar_init_controller()
Date: Tue, 13 Feb 2018 06:40:05 -0800
Message-ID: <20180213144005.GM695913@devbig577.frc2.facebook.com>
References: <1518525803-17378-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1518525803-17378-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Feb 13, 2018 at 01:43:23PM +0100, Geert Uytterhoeven wrote:
> drivers/ata/sata_rcar.c: In function 'sata_rcar_init_controller':
> drivers/ata/sata_rcar.c:821:8: warning: unused variable 'base' [-Wunused-variable]
> 
> Fixes: da77d76b95a0e894 ("sata_rcar: Reset SATA PHY when Salvator-X board resumes")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to libata/for-4.16-fixes.

Thanks.

-- 
tejun
