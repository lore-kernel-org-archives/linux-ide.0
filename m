From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/4] libata: make ata_set_mode() responsible for failure
 handling
Date: Mon, 13 Mar 2006 04:56:14 -0500
Message-ID: <441541BE.80505@pobox.com>
References: <11422375531645-git-send-email-htejun@gmail.com> <44152F3D.50307@pobox.com> <20060313094401.GD2091@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:56038 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750952AbWCMJ4T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 04:56:19 -0500
In-Reply-To: <20060313094401.GD2091@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Mon, Mar 13, 2006 at 03:37:17AM -0500, Jeff Garzik wrote:
> 
>>I have the following concern with this patch (#3) however:
>>
>>
>>>-static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
>>>+static int ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
>>>{
>>>-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
>>>-		return;
>>
>>I think you drop too many ATA_FLAG_PORT_DISABLED tests in this patch, 
>>leading the code to potentially miss a previously-flagged PORT_DISABLED 
>>(perhaps by an LLDD).
>>
> 
> 
> Hmmm... the plan is to disallow LLDD's take ports or devices offline
> from low level callbacks.  They should just let upper layer know by
> returning failure code.

Long term that plan is fine, but you still have to deal with the 
existing API one way or another.  ata_port_disable() is called directly 
by a bunch of Alan's PATA drivers, and by ata_piix and sata_mv.

Thus you would either need to keep the PORT_DISABLED checks or convert 
the drivers in question to a better API.

So just check those ata_port_disable() cases...

	Jeff


