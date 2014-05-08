From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_at91 only works on sam9
Date: Thu, 8 May 2014 11:00:42 -0400
Message-ID: <20140508150042.GD5229@htj.dyndns.org>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-10-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399560990-1402858-10-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-ide@vger.kernel.org

On Thu, May 08, 2014 at 04:56:21PM +0200, Arnd Bergmann wrote:
> The smc driver used by pata_at91 is at91sam9 specific, so building
> this driver on another at91 platform results in this error:
> 
> ERROR: "sam9_smc_configure" [drivers/ata/pata_at91.ko] undefined!
> ERROR: "sam9_smc_write_mode" [drivers/ata/pata_at91.ko] undefined!
> ERROR: "sam9_smc_read_mode" [drivers/ata/pata_at91.ko] undefined!
> 
> This patch changes the Kconfig dependency to ensure it always works.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
