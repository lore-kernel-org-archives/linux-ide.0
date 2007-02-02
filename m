From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Fri, 02 Feb 2007 08:25:35 -0500
Message-ID: <45C33BCF.2040506@emc.com>
References: <20070202063748.GC1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:25914 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161122AbXBBNZp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 08:25:45 -0500
In-Reply-To: <20070202063748.GC1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>


Tejun Heo wrote:

>Both ATA and ATAPI devices used the default timeouts defined by SCSI
>high level driver.  For both disks and ODDs, it was 30secs, which was
>way too long for disks.  This patch makes most ATA commands time out
>after 7secs - the de facto ATA command timeout, while leaving ATAPI
>timeout at 30secs.
>
>Note that both normal commands and EH commands timeouts are adjusted
>to 7 secs, but cache flushses still have 30sec timeout.  This is a
>side effect of the way sd makes use of sdev->timeout, but this is a
>good side effect in that ATA spec requires cache flushes are given
>longer timeout.
>
>
>  
>
I am not sure that this is really a requirement that ATA (or S-ATA) 
drives can meet.  There are definitely error conditions that will exceed 
7 seconds and take that 30 second time to respond.

If the drive is stuck in recovery mode and we retry too soon, we are 
going to be likely to write off a perfectly good disk which would be a 
huge downside ;-)

ric



