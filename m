From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 0/8] sata_mv interrupt/eh fixes etc..
Date: Wed, 23 Apr 2008 09:32:21 -0400
Message-ID: <480F3A65.1090502@rtr.ca>
References: <480A3D2E.4040503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4447 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbYDWNc0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 09:32:26 -0400
In-Reply-To: <480A3D2E.4040503@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> Here are eight more patches for sata_mv.
> 
> The focus this time is on a revamp of the interrupt and error handling code,
> and re-enabling hotplug (primary ports only) at the end.
> 
> The Marvell chips cannot support Asynchronous Notification (AN)
> due to errata issues, so hotplug on PM ports is not supported for now.
> Hotplug on PM ports would require Tejun's HP polling framework.
..

Jeff?  Are you waiting for a complete series repost or something,
or just as busy as the rest of us are right now?  :)

Thanks
