From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: clean up IDENTIFY printing
Date: Mon, 13 Mar 2006 00:51:00 -0500
Message-ID: <44150844.8010001@garzik.org>
References: <44144172.9040304@garzik.org> <20060312165701.GA9051@htj.dyndns.org> <44146758.6090006@garzik.org> <20060313053350.GD29870@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:64476 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932318AbWCMFvD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 00:51:03 -0500
In-Reply-To: <20060313053350.GD29870@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Printing info about IDENTIFY page used to be the responsibility of
> ata_dev_read_id().  As all devices are revalidated after xfer mode
> configuration, this resulted in two info messages about one device.
> This patch improves ata_dump_id() such that it can be generally
> useable and makes printing the responsibility of ata_dev_configure()
> which has better understanding of what's going on.
> 
> The IDENTIFY info printing now looks like the following.
> 
> ata2: dev 1 cfg 49:2f00 53:0007 63:0007 64:0003 75:001f 80:00fe 81:0000 82:346b
>                 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f 93:0000
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

That doesn't address the issue of an increase in log spam :)  When you 
read kernel messages with dmesg(8), KERN_DEBUG does nothing to decrease 
the visibility of any set of messages.

So, please just decrease the current output from a doubled line to a 
single line of data.

Anything more falls under the category of 'implement ap->msg_enable, and 
then use ata_msg_xxx()'.

	Jeff



