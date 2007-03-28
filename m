From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Why is NCQ enabled by default by libata? (2.6.20)
Date: Wed, 28 Mar 2007 10:48:51 -0400
Message-ID: <460A8053.3040209@garzik.org>
References: <20070327161616.31448.qmail@science.horizon.com> <Pine.LNX.4.64.0703271224400.5965@p34.internal.lan> <460A7EE7.5070101@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45301 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbXC1Ot1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Mar 2007 10:49:27 -0400
In-Reply-To: <460A7EE7.5070101@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux@horizon.com, htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Justin Piszcz wrote:
>> I would try with write-caching enabled.
>> Also, the RAID5/RAID10 you mention seems like each volume is on part of
>> the platter, a strange setup you got there :)
> 
> Shouldn't NCQ only help write performance if write caching is 
> _disabled_?  Since write cache essentially is just non tagged command 
> queuing?

NCQ provides for a more asynchronous flow.  It helps greatly with reads 
(of which most are, by nature, synchronous at the app level) from 
multiple threads or apps.  It helps with writes, even with write cache 
on, by allowing multiple commands to be submitted and/or retired at the 
same time.

	Jeff



