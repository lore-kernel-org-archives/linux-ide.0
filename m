From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 3/3] libata: handle AN interrupt
Date: Thu, 29 Mar 2007 11:13:36 +0900
Message-ID: <460B20D0.7010009@gmail.com>
References: <20070328230108.597741522@intel.com> <20070328164457.a675a7d2.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:6138 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934301AbXC2CNo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 22:13:44 -0400
Received: by ug-out-1314.google.com with SMTP id 44so393714uga
        for <linux-ide@vger.kernel.org>; Wed, 28 Mar 2007 19:13:43 -0700 (PDT)
In-Reply-To: <20070328164457.a675a7d2.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Kristen Carlson Accardi wrote:
> When we get an SDB FIS with the 'N' bit set, we should send
> an event to user space to indicate that there has been a
> media change.  The ahci host controller will send the
> event via KOBJ_CHANGE uevent.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
>  
> +static void async_notify_thread(struct work_struct *work)
> +{
> +	struct ata_device *atadev =
> +		container_of(work, struct ata_device, async_notify);
> +
> +	/*
> +	 * TBD - who should send this event?  I couldn't find an
> +	 * easy way to map an ata_device to a genhd device, so
> +	 * decided maybe the ata host should send the event and
> +	 * allow user space to figure out what happened?
> +	 */
> +	kobject_uevent(&atadev->ap->host->dev->kobj, KOBJ_CHANGE);
> +}

I don't think this is right.  If you're gonna make media_change_event 
capability generic, you gotta make event delivery generic too.  You can 
make it a genhd event and make genhd supply the interface function, say, 
genhd_notify_media_change() which is then forwarded by SCSI layer.

Thanks.

-- 
tejun
