From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: clean up IDENTIFY printing
Date: Mon, 13 Mar 2006 02:42:25 -0500
Message-ID: <44152261.2080203@garzik.org>
References: <44144172.9040304@garzik.org> <20060312165701.GA9051@htj.dyndns.org> <44146758.6090006@garzik.org> <20060313053350.GD29870@htj.dyndns.org> <20060313054807.GA24419@htj.dyndns.org> <44150897.1060602@garzik.org> <20060313064016.GA26732@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:47327 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932099AbWCMHm1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 02:42:27 -0500
In-Reply-To: <20060313064016.GA26732@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Printing info about IDENTIFY page used to be the responsibility of
> ata_dev_read_id().  As all devices are revalidated after xfer mode
> configuration, this resulted in two info messages about one device.
> Also, ata_dump_id() was called from ata_dev_configure() which prints
> some intersecting and some new information IDENTIFY page if ATA_DEBUG
> is enabled.
> 
> This patch makes ata_dev_configure() soley responsible for printing
> IDENTIFY info and kill all others.
> 
> The IDENTIFY info printing now looks like the following.
> 
> ata2: dev 1 cfg 49:2f00 53:0007 63:0007 64:0003 75:001f 80:00fe 81:0000 82:346b
>                 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f 93:0000
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
> How about this one?  ata10's second line will be misaligned though. :-p

better, but

* I only want one line of dev->id printed, just like 2.6.15 etc. does 
now.  If you want more verbose dump of additional registers, that's a 
job for ap->msg_enable.

* [you know this was coming :)]  The use of new local 'id' should be 
split into a separate patch.


