From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
Date: Thu, 05 Aug 2004 21:45:59 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4112E2D7.9020606@pobox.com>
References: <41126458.1050203@emc.com>	 <1091724300.8043.58.camel@localhost.localdomain>	 <4112BF1E.9070404@pobox.com> <1091750465.8366.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18618 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268041AbUHFBqv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Aug 2004 21:46:51 -0400
In-Reply-To: <1091750465.8366.54.camel@localhost.localdomain>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brett Russ <russb@emc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Alan Cox wrote:
> On Gwe, 2004-08-06 at 00:13, Jeff Garzik wrote:
> 
>>Alan Cox wrote:
>>
>>>Once Jeff has MWDMA and ATAPI in the new SATA/ATA driver he wrote then
>>>migration might be an even better option. It'll certainly be easier to
>>>do a lot of things right with the newest SATA code than with the current
>>>IDE layer.
>>
>>BTW MWDMA is already done and checked in :)
> 
> 
> Do ATAPI and I'll be glad to help move the other drivers over. I need
> hotplug for my PIIX controller and SI680!


ATAPI works too.....  assuming your CD/DVD drive never encounters a 
CHECK CONDITION requiring REQUEST SENSE to be issued...  ;-)

	Jeff


