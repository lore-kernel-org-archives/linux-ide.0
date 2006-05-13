From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Fri, 12 May 2006 21:30:45 -0400
Message-ID: <446536C5.80503@pobox.com>
References: <44614592.7080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:26847 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751288AbWEMBbE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 May 2006 21:31:04 -0400
In-Reply-To: <44614592.7080301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> tested.  I implemented AHCI PM support half-way but then realized I 
> don't have any AHCI controller which supports PM (I have ICH7R).  Is 
> there any AHCI controller which reports PM support?

You can always use SCR-based PM support...

	Jeff


