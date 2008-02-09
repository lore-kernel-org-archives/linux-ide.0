From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-floppy: remove struct idefloppy_id_gcw
Date: Sat, 9 Feb 2008 16:21:05 +0100
Message-ID: <200802091621.05671.bzolnier@gmail.com>
References: <20080209080334.GA23177@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755195AbYBIQSW@vger.kernel.org>
In-Reply-To: <20080209080334.GA23177@gollum.tnic>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Saturday 09 February 2008, Borislav Petkov wrote:
> commit a6aaf3dd3e88d1bd1e85fb4329042ecb9247e0eb
> Author: Borislav Petkov <petkovbb@gmail.com>
> Date:   Fri Feb 8 18:21:47 2008 +0100
> 
>     ide-floppy: remove struct idefloppy_id_gcw
>     
>     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied with some changes

> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index faf22d7..5d5bde8 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c

[...]

>  #ifdef CONFIG_PPC
>  	/* kludge for Apple PowerBook internal zip */
> -	if ((gcw.device_type == 5) &&
> -	    !strstr(id->model, "CD-ROM") &&
> -	    strstr(id->model, "ZIP"))
> -		gcw.device_type = 0;
> +	if ((device_type == 5) &&
> +		trstr(id->model, "CD-ROM") &&
                ^^^^^

[...]

> -	else if (!gcw.removable)
> -		printk(KERN_ERR "ide-floppy: The removable flag is not set\n");
> -	else if (gcw.drq_type == 3) {
> +				"to floppy\n", device_type);
> +	else if (!removable)
> +		printk(KERN_ERR "ide-floppy: The removable flag (0x%02x) is not"

no need to dump it (it is a single bit flag)

[ please document such changes in patch description ]

> +	else if (drq_type == 3) {
>  		printk(KERN_ERR "ide-floppy: Sorry, DRQ type (0x%02x) not "
> -				"supported\n", gcw.drq_type);
> -	} else if (gcw.packet_size != 0) {
> +				"supported\n", drq_type);
> +	} else if (packet_size != 0) {
>  		printk(KERN_ERR "ide-floppy: Packet size (0x%02x) is not 12 "
> -				"bytes long\n", gcw.packet_size);
> +				"bytes\n", packet_size);
>  	} else

needless braces can be removed while at it
