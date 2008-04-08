From: Richard Zidlicky <rz@linux-m68k.org>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and
	->ata_*put_data methods
Date: Tue, 8 Apr 2008 11:40:29 +0200
Message-ID: <20080408094029.GA1005@linux-m68k.org>
References: <200803301714.04527.bzolnier@gmail.com> <200803302134.42569.bzolnier@gmail.com> <Pine.LNX.4.64.0803310750230.6871@anakin> <200804072113.42441.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:45369 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbYDHJgl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2008 05:36:41 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2564405fkr.5
        for <linux-ide@vger.kernel.org>; Tue, 08 Apr 2008 02:36:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200804072113.42441.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>

On Mon, Apr 07, 2008 at 09:13:42PM +0200, Bartlomiej Zolnierkiewicz wrote:

> 
> v2:
> * Add 'struct request *rq' argument to ->ata_{in,out}put_data methods
>   and don't byte-swap disk fs requests (we shouldn't un-swap fs requests
>   because fs itself is stored byte-swapped on the disk) - this is how
>   things were done before the patch (ideally device mapper should be
>   used instead but it would break existing setups and would have some
>   performance impact).

I like the part about checking 'struct request *rq', will make a  clean
distinction between ide command data and ide disk/medium data which is badly
needed.

However, not only FS data is byteswapped, complete disk including partition
table and everything else is. Will "rq->cmd_type == REQ_TYPE_FS" also catch
all these cases?



> Index: b/drivers/ide/legacy/falconide.c
> ===================================================================
> --- a/drivers/ide/legacy/falconide.c
> +++ b/drivers/ide/legacy/falconide.c
> @@ -44,6 +44,36 @@
>  int falconide_intr_lock;
>  EXPORT_SYMBOL(falconide_intr_lock);
>  
> +static void falconide_atapi_input_bytes(ide_drive_t *drive, void *buf,
> +					unsigned int len)
> +{
> +	insw_swapw(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
> +}
> +
> +static void falconide_atapi_output_bytes(ide_drive_t *drive, void *buf,
> +					 unsigned int len)
> +{
> +	outsw_swapw(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
> +}
> +
> +static void falconide_ata_input_data(ide_drive_t *drive, struct request *rq,
> +				     void *buf, unsigned int wcount)
> +{
> +	if (drive->media == ide_disk && rq && rq->cmd_type == REQ_TYPE_FS)
> +		return insw(drive->hwif->io_ports.data_addr, buf, wcount * 2);
> +
> +	falconide_atapi_input_bytes(drive, buf, wcount * 4);
> +}

this will still do double swapping for disk access, although this is very
easier to fix once the distinction between ide and disk data works fine.

So IMHO despite the little concerns this is the way to go.

Richard
