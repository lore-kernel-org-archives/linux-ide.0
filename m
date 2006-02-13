From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] Replace assert() with WARN_ON in drivers/scsi/libata-core.c
Date: Mon, 13 Feb 2006 15:45:18 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602131543270.18300@shark.he.net>
References: <20060213233518.15196.57162.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:45034 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030299AbWBMXpU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Feb 2006 18:45:20 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2006 15:45:18 -0800
In-Reply-To: <20060213233518.15196.57162.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aubin LaBrosse <aubin@stormboxes.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 13 Feb 2006, Aubin LaBrosse wrote:

>
> Replace assert() with WARN_ON in drivers/scsi/libata-core.c
>
> This is my first patch to the kernel - this work was suggested by Jeff Garzik as a janitorial task for libata.  If I could get some feedback letting me know that this is the correct format and my tools are setup right, I'll do the rest of these.
>
> Signed-off-by: Aubin LaBrosse <aubin@stormboxes.com>

Jeff wrote an email a couple of days ago that he already has
several of these patches...

> @@ -1251,8 +1251,8 @@ static void ata_dev_identify(struct ata_
>
>  	DPRINTK("ENTER, host %u, dev %u\n", ap->id, device);
>
> -	assert (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ATAPI ||
> -		dev->class == ATA_DEV_NONE);
> +	WARN_ON(dev->class != ATA_DEV_ATA &&&dev->class != ATA_DEV_ATAPI &&
> +		dev->class != ATA_DEV_NONE);

Does that one compile cleanly?

>
>  	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
>

Otherwise it looks pretty good to me.

-- 
~Randy
