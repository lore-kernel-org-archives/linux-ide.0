From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA RAID5 speed drop of 100 MB/s
Date: Sat, 23 Jun 2007 18:43:01 -0400
Message-ID: <467DA1F5.2060306@garzik.org>
References: <20070620224847.GA5488@alinoe.com> <4679B2DE.9090903@garzik.org> <20070622214859.GC6970@alinoe.com> <467CC5C5.6040201@garzik.org> <20070623125316.GB26672@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40881 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbXFWWnJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jun 2007 18:43:09 -0400
In-Reply-To: <20070623125316.GB26672@alinoe.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlo Wood <carlo@alinoe.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Manoj Kasichainula <manoj@io.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Carlo Wood wrote:
> Is it possible that the measurement with "hdparm -tT" returns a higher
> value for some setting, but that the over-all real-life performance
> drops?

IN THEORY, RAID performance should /increase/ due to additional queued 
commands available to be sent to the drive.  NCQ == command queueing == 
sending multiple commands to the drive, rather than one-at-a-time like 
normal.

But hdparm isn't the best test for that theory, since it does not 
simulate the transactions like real-world MD device usage does.

We have seen buggy NCQ firmwares where performance decreases, so it is 
possible that NCQ just isn't good on your drives.

	Jeff


