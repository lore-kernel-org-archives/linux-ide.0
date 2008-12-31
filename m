From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: PIO with SSDs: needs a long DRQ-after-command timeout for WRITEs
Date: Wed, 31 Dec 2008 21:06:04 +0300
Message-ID: <495BB48C.3090408@ru.mvista.com>
References: <495A27E3.50801@rtr.ca> <495A6513.9070609@shaw.ca> <495B9D31.6080904@rtr.ca> <495BACD2.6020500@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:47171 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755635AbYLaSFj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Dec 2008 13:05:39 -0500
In-Reply-To: <495BACD2.6020500@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ide <linux-ide@vger.kernel.org>

Robert Hancock wrote:

>>> No idea about IDE, but libata does not wait at all for DRQ assertion 
>>> specifically, after issuing the PIO command it waits for BSY to be 
>>> deasserted and then expects either DRQ, DF or ERR to be set, else 
>>> it's a host state machine violation and triggers error handling. 
>>> According to the ATA spec, the device is specifically not allowed to 
>>> set DRQ to one while BSY is not asserted.

> IDE is really only waiting 50msec in this case? That seems rather 

    The whole 100 ms if you look at how WAIT_DRQ is #define'd...

MBR, Sergei
