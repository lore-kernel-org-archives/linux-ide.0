From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] ide-cd cleanup (casts, whitespace and codingstyle)
Date: Tue, 4 Oct 2005 03:04:21 +0400
Message-ID: <20051003230421.GE7554@mipter.zuzino.mipt.ru>
References: <200510040017.57168.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932436AbVJCWxQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200510040017.57168.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andersen@codepoet.org, axboe@suse.de
List-Id: linux-ide@vger.kernel.org

On Tue, Oct 04, 2005 at 12:17:56AM +0200, Jesper Juhl wrote:
> --- linux-2.6.14-rc3-git3-orig/drivers/ide/ide-cd.c
> +++ linux-2.6.14-rc3-git3/drivers/ide/ide-cd.c

What was wrong with these ones? [snipping the rest]

>  static int cdrom_log_sense(ide_drive_t *drive, struct request *rq,
> -			   struct request_sense *sense)
> +		struct request_sense *sense)

> -static
> -void cdrom_analyze_sense_data(ide_drive_t *drive,
> -			      struct request *failed_command,
> -			      struct request_sense *sense)
> +static void cdrom_analyze_sense_data(ide_drive_t *drive,
> +		struct request *failed_command, struct request_sense *sense)

>  static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
> -				      struct request *failed_command)
> +		struct request *failed_command)

>  static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
> -						  int xferlen,
> -						  ide_handler_t *handler)
> +		int xferlen, ide_handler_t *handler)
