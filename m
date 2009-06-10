From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: add warning messages for hp laptops
 with broken suspend
Date: Wed, 10 Jun 2009 04:16:46 -0400
Message-ID: <4A2F6BEE.5050208@garzik.org>
References: <4A211D74.5070208@kernel.org> <4A2F630E.3080904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45215 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203AbZFJIQv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 04:16:51 -0400
In-Reply-To: <4A2F630E.3080904@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, kernel.org@epperson.homelinux.net, emisca@gmail.com, Gadi Cohen <dragon@wastelands.net>, Paul Swanson <paul@procursa.com>, s@ourada.org, Trevor Davenport <trevor.davenport@gmail.com>, corruptor1972 <steven_tierney@yahoo.co.uk>, Victoria Wilson <mail@vwilson.co.uk>, khiraly <khiraly.list@gmail.com>, Sean <wollombi@gmail.com>

Tejun Heo wrote:
> Tejun Heo wrote:
>> Harddisks on HP dv[4-6] and HDX18 fail to come online after resume on
>> earlier BIOSen.  Fortunately, HP recently released BIOS updates for
>> all machines to fix the issue.  Detect old BIOSen, warn the user to
>> update BIOS on boot and suspend attempts and fail suspend.
> 
> Ping.


eh?  This is upstream as 9b10ae86d1616f46dabb67c663fe6a9c3a502663

	Jeff


