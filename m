From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: RFC: Compact Flash True IDE Mode Driver
Date: Tue, 14 Feb 2006 17:24:50 +0100
Message-ID: <58cb370e0602140824p32991ba3sa5e731a1394c3fbe@mail.gmail.com>
References: <58cb370e0602140757r5b265f25wc9f1f2e44d5f075c@mail.gmail.com>
	 <Pine.LNX.4.44.0602141007090.27351-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161112AbWBNQYx@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0602141007090.27351-100000@gate.crashing.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 2/14/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> If this looks good, I'll send a more official patch with an signed-off-by.

Looks good but please add some description and Signed-off-by.

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

You can send final patch to akpm for inclusion into -mm.

> - k
>
> diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> index 09086b8..359f659 100644
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -977,8 +977,6 @@ static void idedisk_setup (ide_drive_t *
>                 ide_dma_verbose(drive);
>         printk("\n");
>
> -       drive->no_io_32bit = id->dword_io ? 1 : 0;
> -
>         /* write cache enabled? */
>         if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
>                 drive->wcache = 1;
> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> index 427d1c2..1b7b4c5 100644
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -858,6 +858,15 @@ static void probe_hwif(ide_hwif_t *hwif)
>                         }
>                 }
>         }
> +
> +       for (unit = 0; unit < MAX_DRIVES; ++unit) {
> +               ide_drive_t *drive = &hwif->drives[unit];
> +
> +               if (hwif->no_io_32bit)
> +                       drive->no_io_32bit = 1;
> +               else
> +                       drive->no_io_32bit = drive->id->dword_io ? 1 : 0;
> +       }
>  }
>
>  static int hwif_init(ide_hwif_t *hwif);
> diff --git a/include/linux/ide.h b/include/linux/ide.h
> index a7fc4cc..8d2db41 100644
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -792,6 +792,7 @@ typedef struct hwif_s {
>         unsigned        no_dsc     : 1; /* 0 default, 1 dsc_overlap disabled */
>         unsigned        auto_poll  : 1; /* supports nop auto-poll */
>         unsigned        sg_mapped  : 1; /* sg_table and sg_nents are ready */
> +       unsigned        no_io_32bit : 1; /* 1 = can not do 32-bit IO ops */
>
>         struct device   gendev;
>         struct completion gendev_rel_comp; /* To deal with device release() */
