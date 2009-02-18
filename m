From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Bad module reference counter
Date: Wed, 18 Feb 2009 22:25:19 +0100
Message-ID: <200902182225.19784.bzolnier@gmail.com>
References: <200902111032.59225.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:46087 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbZBRVXw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Feb 2009 16:23:52 -0500
Received: by fxm11 with SMTP id 11so12361fxm.13
        for <linux-ide@vger.kernel.org>; Wed, 18 Feb 2009 13:23:49 -0800 (PST)
In-Reply-To: <200902111032.59225.stf_xl@wp.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org

On Wednesday 11 February 2009, Stanislaw Gruszka wrote:
> Hello.
> 
> I entered a problem with double decreasing module reference counter
> where it become "negative", here is the usage scenario:
> 
> # modprobe at91_ide
> # modprobe ide_gd_mod
> # lsmod
> Module                  Size  Used by    Not tainted
> ide_gd_mod             22948  0
> at91_ide                4672  0
> ide_core               77020  2 ide_gd_mod,at91_ide
> # rmmod ide_gd_mod
> # lsmod
> Module                  Size  Used by    Not tainted
> at91_ide                4672 4294967295
> ide_core               77020  1 at91_ide
> 
> Note when I first remove at91_ide module and then ide_gd_mod
> everyting is ok.
> 
> I tired to debug issue and I did not found any suspicious in at91_ide.
> I think probable reason is double free in ide-gd.c . Here is patch with
> workaround (or maybe it is a real fix, but I'm not sure):
> 
> diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
> index 7857b20..31ae04e 100644
> --- a/drivers/ide/ide-gd.c
> +++ b/drivers/ide/ide-gd.c
> @@ -70,8 +70,6 @@ static void ide_gd_remove(ide_drive_t *drive)
>  	del_gendisk(g);
>  
>  	drive->disk_ops->flush(drive);
> -
> -	ide_disk_put(idkp);
>  }
>  
>  static void ide_disk_release(struct kref *kref)
> 
> If this patch is ok, maybe similar things need to be done also in ide-cd and
> perhaps other device type modules.

Seems like ide_device_put() needs the same module_refcount() check that
is present in scsi_device_put() so removal of device driver won't trigger
a spurious module_put() on a host driver?

Thanks,
Bart
