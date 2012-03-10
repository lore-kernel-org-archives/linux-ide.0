From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 1/1] ata: AT91 ata driver requires specific platforms
Date: Sat, 10 Mar 2012 19:56:50 +0000
Message-ID: <20120310195650.GD32060@trinity.fluff.org>
References: <1331405617-4053-1-git-send-email-alan@signal11.us> <1331405652-4100-1-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331405652-4100-1-git-send-email-alan@signal11.us>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-ide@vger.kernel.org

On Sat, Mar 10, 2012 at 01:54:12PM -0500, Alan Ott wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver uses registers defined in a per-soc header file.
> Since not every soc in the at91 platform defines those, make
> the Kconfig option dependent on specifically the socs that
> do.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alan Ott <alan@signal11.us>
> ---
>  drivers/ata/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 6bdedd7..16c6b78 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -731,6 +731,7 @@ config PATA_AT32
>  config PATA_AT91
>  	tristate "PATA support for AT91SAM9260"
>  	depends on ARM && ARCH_AT91
> +	depends on ARCH_AT91SAM9260 || ARCH_AT91SAM9G20 || ARCH_AT91SAM9261 ||  ARCH_AT91SAM9G10 || ARCH_AT91SAM9263 || ARCH_AT91SAM9RL || ARCH_AT91SAM9G45 || ARCH_AT91CAP9
>  	help

How about adding an AT91_HAS_PATA kconfig and having the arch/arm/... Kconfig
select it as necessary. It will avoid future fun when another device comes
out.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
