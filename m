From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: ahci_mvebu: Fix wrongly set base address for the
 MBus window setting
Date: Tue, 26 May 2015 14:47:28 -0400
Message-ID: <20150526184728.GJ7099@htj.duckdns.org>
References: <1432658843-27622-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432658843-27622-1-git-send-email-gregory.clement@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, May 26, 2015 at 06:47:23PM +0200, Gregory CLEMENT wrote:
> From: Nadav Haklai <nadavh@marvell.com>
> 
> According to the Armada 38x datasheet, the window base address
> registers value is set in bits [31:4] of the register and corresponds
> to the transaction address bits [47:20].
> 
> Therefore, the 32bit base address value should be shifted right by
> 20bits and left by 4bits, resulting in 16 bit shift right.
> 
> The bug as not been noticed yet because if the memory available on
> the platform is less than 2GB, then the base address is zero.
> 
> [gregory.clement@free-electrons.com: add extra-explanation]
> 
> Fixes: a3464ed2f14 (ata: ahci_mvebu: new driver for Marvell Armada 380
> AHCI interfaces)
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Reviewed-by: Omri Itach <omrii@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: <stable@vger.kernel.org>

Applied to libata/for-4.1-fixes.

Thank you.

-- 
tejun
