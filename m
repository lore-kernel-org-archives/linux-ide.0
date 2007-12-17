From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Fix build break caused by "ide: remove ideprobe_init()"
Date: Mon, 17 Dec 2007 21:53:31 +0100
Message-ID: <200712172153.31427.bzolnier@gmail.com>
References: <200711182325.09262.bzolnier@gmail.com>
	<20071214090915.GA28681@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20071214090915.GA28681@lixom.net>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Friday 14 December 2007, Olof Johansson wrote:
> Fix build break of powerpc holly_defconfig:

Sorry for breaking the hol[l]y powerpc platform. ;)

> In file included from arch/powerpc/platforms/embedded6xx/holly.c:24:
> include/linux/ide.h:1206: error: 'CONFIG_IDE_MAX_HWIFS' undeclared here (not in a function)
> 
> There's no need to have a sized array in the prototype, might as well
> turn it into a pointer.
> 
> It could probably be argued that large parts of the include file can be
> covered under #ifdef CONFIG_IDE, but that's a larger undertaking.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

applied but...

> ---
> 
> On Sun, Nov 18, 2007 at 11:25:09PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > * Rename ide_device_add() to ide_device_add_all() and make it accept
> >   'u8 idx[MAX_HWIFS]' instead of 'u8 idx[4]' as an argument.
> > 
> > * Add ide_device_add() wrapper for ide_device_add_all().
> > 
> > * Convert ide_generic_init() to use ide_device_add_all().
> > 
> > * Remove no longer needed ideprobe_init().
> > 
> > There should be no functionality changes caused by this patch.
> 
> This patch broke builds of powerpc holly_defconfig in -mm. It has
> CONFIG_EMBEDDED=y, CONFIG_IDE=n but includes linux/ide.h:
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

...could you also fix the root source of the problem so the similar issue
won't re-appear in the future?

<linux/ide.h> is IDE subsystem specific in the same way that <linux/libata.h>
is libata specific, <linux/ata.h> is the place to put subsystem independent
defines, inlines and co.

There are some powerpc abusers of the above rule but they should at least cover
references to <linux/ide.h> and IDE subsystem specific code with #ifdef/#endif
CONFIG_BLK_DEV_IDE.

In arch/powerpc/platforms/embedded6xx/holly.c case it seems that <linux/ide.h>
include is actually not needed and may be just removed?

Bart

> Index: mm/drivers/ide/ide-probe.c
> ===================================================================
> --- mm.orig/drivers/ide/ide-probe.c
> +++ mm/drivers/ide/ide-probe.c
> @@ -1335,7 +1335,7 @@ static void hwif_register_devices(ide_hw
>  	}
>  }
>  
> -int ide_device_add_all(u8 idx[MAX_HWIFS])
> +int ide_device_add_all(u8 *idx)
>  {
>  	ide_hwif_t *hwif;
>  	int i, rc = 0;
> Index: mm/include/linux/ide.h
> ===================================================================
> --- mm.orig/include/linux/ide.h
> +++ mm/include/linux/ide.h
> @@ -1203,7 +1203,7 @@ void ide_unregister_region(struct gendis
>  
>  void ide_undecoded_slave(ide_drive_t *);
>  
> -int ide_device_add_all(u8 idx[MAX_HWIFS]);
> +int ide_device_add_all(u8 *idx);
>  int ide_device_add(u8 idx[4]);
>  
>  static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
