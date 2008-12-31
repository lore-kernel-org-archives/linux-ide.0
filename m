From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: PIO with SSDs: needs a long DRQ-after-command timeout for WRITEs
Date: Wed, 31 Dec 2008 21:03:52 +0300
Message-ID: <495BB408.7000608@ru.mvista.com>
References: <495A27E3.50801@rtr.ca> <495A6513.9070609@shaw.ca> <495B9D31.6080904@rtr.ca> <495BACD2.6020500@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:47133 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756529AbYLaSD2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Dec 2008 13:03:28 -0500
In-Reply-To: <495BACD2.6020500@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ide <linux-ide@vger.kernel.org>

Hello.

Robert Hancock wrote:

>>> No idea about IDE, but libata does not wait at all for DRQ assertion 
>>> specifically, after issuing the PIO command it waits for BSY to be 
>>> deasserted and then expects either DRQ, DF or ERR to be set, else 
>>> it's a host state machine violation and triggers error handling. 
>>> According to the ATA spec, the device is specifically not allowed to 
>>> set DRQ to one while BSY is not asserted.

>> ..

>> Okay, so how long does it wait for BSY=0 under that same circumstance?

> Just the overall command completion timeout, it would appear.. usually 
> 30 seconds I believe.

    I don't think it's as long as that with libata.

> IDE is really only waiting 50msec in this case? That seems rather 
> wrong.. I don't see anywhere in the current ATA specs that requires the 
> drive to respond within that time period.

    It's waiting the whole 50 ms where the maximum specified by the original 
ATA was 20 ms. What seems really wrong to me is making the host poll for BSY=0 
for an indeterminate time -- though it's always been a really stupid part of 
the ATA command protocol. Well, at least it never stroke anybody before those 
insane SSDs appeared on market. :-)

WBR, Sergei
