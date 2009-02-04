From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/4] ide: remove IDE_ARCH_LOCK
Date: Wed, 4 Feb 2009 22:27:36 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0902042226440.25136@anakin>
References: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
 <20090127180259.28089.56908.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20090127180259.28089.56908.sendpatchset@localhost.localdomain>
Sender: linux-m68k-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Michael Schmitz <schmitz@debian.org>, linux-m68k@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 27 Jan 2009, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: remove IDE_ARCH_LOCK
> 
> * Add ->{get,release}_lock methods to struct ide_port_info
>   and struct ide_host.
> 
> * Convert core IDE code, m68k IDE code and falconide support to use
>   ->{get,release}_lock methods instead of ide_{get,release}_lock().
> 
> * Remove IDE_ARCH_LOCK.
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michael Schmitz <schmitz@debian.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> We may also consider adding struct ide_host_ops later...
> 
>  drivers/ide/falconide.c |   25 +++++++++++++++++++++++--
>  drivers/ide/ide-io.c    |    8 ++++----
>  drivers/ide/ide-probe.c |    2 ++
>  include/asm-m68k/ide.h  |   36 ------------------------------------
>  include/linux/ide.h     |   16 ++++++++++------
>  5 files changed, 39 insertions(+), 48 deletions(-)
> 
> Index: b/drivers/ide/falconide.c
> ===================================================================
> --- a/drivers/ide/falconide.c
> +++ b/drivers/ide/falconide.c
> @@ -40,8 +40,27 @@
>       *  which is shared between several drivers.
>       */
>  
> -int falconide_intr_lock;
> -EXPORT_SYMBOL(falconide_intr_lock);
> +static int falconide_intr_lock;
> +
> +static void falconide_release_lock(void)
> +{
> +	if (falconide_intr_lock == 0) {
> +		printk(KERN_ERR "%s: bug\n", __func__);
> +		return;
> +	}
> +	falconide_intr_lock = 0;
> +	stdma_release();
> +}
> +
> +static void falconide_get_lock(irq_handler_t handler, void *data)
> +{
> +	if (falconide_intr_lock == 0) {
> +		if (in_interrupt() > 0)
> +			panic("Falcon IDE hasn't ST-DMA lock in interrupt");
> +		stdma_lock(handler, data);
> +		falconide_intr_lock = 1;
> +	}
> +}
>  
>  static void falconide_input_data(ide_drive_t *drive, struct request *rq,
>  				 void *buf, unsigned int len)
> @@ -81,6 +100,8 @@ static const struct ide_tp_ops falconide
>  };
>  
>  static const struct ide_port_info falconide_port_info = {
> +	.get_lock		= falconide_get_lock,
> +	.release_lock		= falconide_release_lock,
>  	.tp_ops			= &falconide_tp_ops,
>  	.host_flags		= IDE_HFLAG_NO_DMA | IDE_HFLAG_SERIALIZE,
>  };

http://kisskb.ellerman.id.au/kisskb/buildresult/71775/

drivers/ide/falconide.c:157: error: implicit declaration of function 'ide_get_lock'
drivers/ide/falconide.c:159: error: implicit declaration of function 'ide_release_lock'

Seems like you forgot to update two callers?

diff --git a/drivers/ide/falconide.c b/drivers/ide/falconide.c
index 1203796..bb0c86e 100644
--- a/drivers/ide/falconide.c
+++ b/drivers/ide/falconide.c
@@ -154,9 +154,9 @@ static int __init falconide_init(void)
 		goto err;
 	}
 
-	ide_get_lock(NULL, NULL);
+	falconide_get_lock(NULL, NULL);
 	rc = ide_host_register(host, &falconide_port_info, hws);
-	ide_release_lock();
+	falconide_release_lock();
 
 	if (rc)
 		goto err_free;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
