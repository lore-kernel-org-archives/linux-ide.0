From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: fixup incomplete ident blocks on ITE raid volumes
Date: Mon, 16 Aug 2004 17:16:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200408161716.35922.bzolnier@elka.pw.edu.pl>
References: <20040815144527.GA7983@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267720AbUHPPYe@vger.kernel.org>
In-Reply-To: <20040815144527.GA7983@devserv.devel.redhat.com>
Content-Disposition: inline
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
List-Id: linux-ide@vger.kernel.org


This should be part of ITE driver patch and be compiled only when ITE driver 
is going to be used or even better - there should be new callback for that.

On Sunday 15 August 2004 16:45, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c
> linux-2.6.8-rc3/drivers/ide/ide-probe.c ---
> linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-09
> 15:51:00.000000000 +0100 +++
> linux-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-14 21:03:03.000000000 +0100
> @@ -542,7 +542,51 @@
>  }
>
>  /**
> - *	probe_for_drives	-	upper level drive probe
> + *	ident_quirks	-	drive ident mangler
> + *	@drive: drive to check
> + *
> + *	Take the returned ident block for the drive and see if it
> + *	is one of the broken ones. We still broken ident fixups in
> + *	multiple places, we should migrate some of the others here.
> + */
> +static void ident_quirks(ide_drive_t *drive)
> +{
> +	struct hd_driveid *id = drive->id;
> +	u16 *idbits = (u16 *)id;
> +
> +	if(strstr(id->model, "Integrated Technology Express"))
> +	{
> +		/* IT821x raid volume with bogus ident block */
> +		if(id->lba_capacity >= 0x200000)
> +		{
> +			id->sectors = 63;
> +			id->heads = 255;
> +		}
> +		else
> +		{
> +			id->sectors = 32;
> +			id->heads = 64;
> +		}
> +		id->cyls = 1 + id->lba_capacity_2 / (id->heads * id->sectors);
> +		/* LBA28 is ok, DMA is ok, UDMA data is valid */
> +		id->capability |= 3;
> +		id->field_valid |= 7;
> +		/* LBA48 is ok */
> +		id->command_set_2 |= 0x0400;
> +		id->cfs_enable_2 |= 0x0400;
> +		/* Flush is ok */
> +		id->cfs_enable_2 |= 0x3000;
> +		printk(KERN_WARNING "%s: IT8212 %sRAID %d volume",
> +			drive->name,
> +			idbits[147] ? "Bootable ":"",
> +			idbits[129]);
> +		if(idbits[129] != 1)
> +			printk("(%dK stripe)", idbits[146]);
> +		printk(".\n");
> +	}
> +}
> +/**
> + *	probe_for_drive	-	upper level drive probe
>   *	@drive: drive to probe for
>   *
>   *	probe_for_drive() tests for existence of a given drive using do_probe()
> @@ -553,7 +597,7 @@
>   *			   still be 0)
>   */
>
> -static inline u8 probe_for_drive (ide_drive_t *drive)
> +static u8 probe_for_drive(ide_drive_t *drive)
>  {
>  	/*
>  	 *	In order to keep things simple we have an id
> @@ -602,6 +646,7 @@
>  				drive->present = 0;
>  			}
>  		}
> +		ident_quirks(drive);
>  		/* drive was found */
>  	}
>  	if(!drive->present)
>
