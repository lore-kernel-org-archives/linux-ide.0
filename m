From: Jeff Garzik <jeff@garzik.org>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP	drive
Date: Wed, 14 Mar 2007 13:42:35 -0400
Message-ID: <45F8340B.5030401@garzik.org>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F7E34B.6020206@gmail.com> <45F7F90B.6070709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42470 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633AbXCNRnI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Mar 2007 13:43:08 -0400
In-Reply-To: <45F7F90B.6070709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Stanislav Brabec <sbrabec@novell.com>, albertl@mail.com, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun wrote:
>> If that's the case, libata should work too as long as the HSM problem is
>> fixed.
> 
> Really?  I didn't notice when libata gained ATAPI-disk support.

ATAPI just passes through to SCSI.  There is no limitation on the 
peripheral device types supported, except in the SCSI midlayer itself.

Some rare ATAPI devices are even pure SCSI bridges, allowing you to hook 
up any SCSI-2 device to the bridge, and in turn, to any ATA/ATAPI 
controller.

	Jeff



