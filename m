From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 14:25:22 +1000
Message-ID: <1217478322.11188.410.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
	 <200807292126.12238.bzolnier@gmail.com>
	 <1217401052.11188.318.camel@pasglop>
	 <200807302111.54514.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50896 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbYGaEZg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 00:25:36 -0400
In-Reply-To: <200807302111.54514.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com


> Is it actually caused by additional reference counting on drive->gendev?
> IOW if you reverse the patch below instead of applying the previous fix
> do things work OK again?
> 
> > Note that there shouldn't be anything fundamentally different from
> > ide-pmac here vs. something like pcmcia IDE cards... do you have one of
> > these to test with ?
> 
> Nope and I really don't intend to have one.  I count on other people
> to take some care of support for host drivers that they maintain/use. ;)

Reverting the patch below does the job. Thanks.

Ben.

> Thanks,
> Bart
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 4e73aee..8f253e5 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -57,23 +57,29 @@ static DEFINE_MUTEX(idecd_ref_mutex);
>  #define ide_cd_g(disk) \
>  	container_of((disk)->private_data, struct cdrom_info, driver)
>  
> +static void ide_cd_release(struct kref *);
> +
>  static struct cdrom_info *ide_cd_get(struct gendisk *disk)
>  {
>  	struct cdrom_info *cd = NULL;
>  
>  	mutex_lock(&idecd_ref_mutex);
>  	cd = ide_cd_g(disk);
> -	if (cd)
> +	if (cd) {
>  		kref_get(&cd->kref);
> +		if (ide_device_get(cd->drive)) {
> +			kref_put(&cd->kref, ide_cd_release);
> +			cd = NULL;
> +		}
> +	}
>  	mutex_unlock(&idecd_ref_mutex);
>  	return cd;
>  }
>  
> -static void ide_cd_release(struct kref *);
> -
>  static void ide_cd_put(struct cdrom_info *cd)
>  {
>  	mutex_lock(&idecd_ref_mutex);
> +	ide_device_put(cd->drive);
>  	kref_put(&cd->kref, ide_cd_release);
>  	mutex_unlock(&idecd_ref_mutex);
>  }

