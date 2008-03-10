From: Mark Lord <liml@rtr.ca>
Subject: Re: Problem with ahci and a external sata disk
Date: Mon, 10 Mar 2008 15:26:05 -0400
Message-ID: <47D58B4D.1030404@rtr.ca>
References: <200802191646.39277.jareguero@telefonica.net> <200803071515.43686.jareguero@telefonica.net> <200803072333.12877.jareguero@telefonica.net> <200803080220.20565.jareguero@telefonica.net> <47D372D8.2010708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2267 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbYCJT0H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Mar 2008 15:26:07 -0400
In-Reply-To: <47D372D8.2010708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jose Alberto Reguero <jareguero@telefonica.net>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jose Alberto Reguero wrote:
>> [root@jar Pls]# hdparm -I /dev/sdd
>>
>> /dev/sdd:
>>
>> ATA device, with non-removable media
>>         Model Number:       ST3750640AS
>>         Serial Number:      5QD3Q2AZ
>>         Firmware Revision:  3.AFM
>>
>> How can be so diferent that the one make with esata?
> 
> That's because your enclosure is emulating IDENTIFY command when
> attached via SATA.  It's emulating USB mass storage device when
> connected via USB but your enclosure is good enough to implement ATA
> command passthrough and as hdparm issues IDENTIFY using command
> passthrough, it gets to the actual drive and returns the result directly.
..

Hey, way cool.. that's the first enclosure I've heard of "in the wild"
that implements ATA command passthru.

Gotta remember that one ("Seagate FreeAgent Pro" USB/eSATA enclosure).

