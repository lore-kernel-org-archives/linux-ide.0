From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide-cd: small drive type print fix
Date: Fri, 3 Oct 2008 19:18:15 +0200
Message-ID: <200810031918.15455.bzolnier@gmail.com>
References: <1222669799-6565-1-git-send-email-petkovbb@gmail.com> <1222669799-6565-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753533AbYJCRoN@vger.kernel.org>
In-Reply-To: <1222669799-6565-3-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Monday 29 September 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied (though I fail to see "an added value" of this change)

> ---
>  drivers/ide/ide-cd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 9ffce7f..e41b94d 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1784,7 +1784,7 @@ static int ide_cdrom_probe_capabilities(ide_drive_t *drive)
>  	if ((cdi->mask & CDC_DVD_R) == 0 || (cdi->mask & CDC_DVD_RAM) == 0)
>  		printk(KERN_CONT " DVD%s%s",
>  				 (cdi->mask & CDC_DVD_R) ? "" : "-R",
> -				 (cdi->mask & CDC_DVD_RAM) ? "" : "-RAM");
> +				 (cdi->mask & CDC_DVD_RAM) ? "" : "/RAM");
>  
>  	if ((cdi->mask & CDC_CD_R) == 0 || (cdi->mask & CDC_CD_RW) == 0)
>  		printk(KERN_CONT " CD%s%s",
