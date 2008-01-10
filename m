From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Wed, 09 Jan 2008 23:35:45 -0500
Message-ID: <4785A0A1.7000003@garzik.org>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>	 <1196610199229-git-send-email-saeed.bishara@gmail.com>	 <47684270.5030405@garzik.org>	 <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com> <c70ff3ad0801090359n669471fap45b67228ded564a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60577 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbYAJEfs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jan 2008 23:35:48 -0500
In-Reply-To: <c70ff3ad0801090359n669471fap45b67228ded564a5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>

saeed bishara wrote:
>> Here is the updated patch according your comments:
>> From af124a0fd4984db4fbc8638e0af4e6a41561588d Mon Sep 17 00:00:00 2001
>> From: Saeed Bishara <saeed@marvell.com>
>> Date: Sun, 2 Dec 2007 10:43:10 +0200
>> Subject: [PATCH] sata_mv: Remove PCI dependency
>>
>> The integrated SATA controller is connected directly to the SoC's
>> internal bus, not via PCI interface. this patch removes the dependency
>> on the PCI interface.
> guys, any other comments for this patch?

sorry, I've been away dealing with some family matters.  So, the "patch 
queue and review" stuff on my side hasn't moved during the holidays. 
Should get going again now...

	Jeff



