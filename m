From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PIO with SSDs: needs a long DRQ-after-command timeout for WRITEs
Date: Wed, 31 Dec 2008 11:33:06 -0600
Message-ID: <495BACD2.6020500@shaw.ca>
References: <495A27E3.50801@rtr.ca> <495A6513.9070609@shaw.ca> <495B9D31.6080904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:55727 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbYLaRdJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Dec 2008 12:33:09 -0500
In-Reply-To: <495B9D31.6080904@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ide <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Robert Hancock wrote:
> ..
>> No idea about IDE, but libata does not wait at all for DRQ assertion 
>> specifically, after issuing the PIO command it waits for BSY to be 
>> deasserted and then expects either DRQ, DF or ERR to be set, else it's 
>> a host state machine violation and triggers error handling. According 
>> to the ATA spec, the device is specifically not allowed to set DRQ to 
>> one while BSY is not asserted.
> ..
> 
> Okay, so how long does it wait for BSY=0 under that same circumstance?

Just the overall command completion timeout, it would appear.. usually 
30 seconds I believe.

IDE is really only waiting 50msec in this case? That seems rather 
wrong.. I don't see anywhere in the current ATA specs that requires the 
drive to respond within that time period.
