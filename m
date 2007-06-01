From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Compact Flash performance...
Date: Thu, 31 May 2007 18:00:12 -0600
Message-ID: <465F618C.1020200@shaw.ca>
References: <fa.XmtWMJk5gwBC00HJh+5O62Vx8eA@ifi.uio.no>
 <fa.fl4+oXGwE5VC39h2DLdFoBUbqV4@ifi.uio.no>
 <fa.+cW0LouEqSiZ6zrmBDeBJxRjPTg@ifi.uio.no>
 <fa.PM7erd/Gm1gq8ZshwTBJwux7o6o@ifi.uio.no>
 <fa.MYVClL+Q9g/jFTcUNWOeysiV0Ig@ifi.uio.no>
 <fa.Q4zXu+xtMAT5H5vbl/zgxZk/Ivo@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:52528 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbXFAAAM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 May 2007 20:00:12 -0400
In-reply-to: <fa.Q4zXu+xtMAT5H5vbl/zgxZk/Ivo@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Daniel J Blueman <daniel.blueman@gmail.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> Mark Lord wrote:
>> To maximize throughput, some kind of host-queuing would be needed,
>> or just have the driver sit in a tight loop, starting the next I/O
>> immediately when the previous one finishes.  Linux isn't that quick 
>> (yet).
> 
> 
> I was talking on IRC with Tejun just recently.  There are several 
> controllers (and/or "situations") like this, where some amount of host 
> queueing would permit greater throughput, even when NCQ is not 
> supported.  sata_sx4 is the most dramatic example, where host queueing 
> could potentially increase speed by a factor of 10 or more, since it is 
> penalized by an awful two-irq-per-command (w/ a per-host bottleneck to 
> boot) setup.  Silicon Image has a "command buffer".  And overall, I 
> designed ->qc_prep() hook separate from ->qc_issue() to enable the 
> prepartion of multiple commands such that it only takes a simple "go" 
> I/O to start a transaction, immediately after the previous one ends.
> 
>     Jeff

Theoretically NVIDIA nForce4 ADMA could likely do this as well, as it 
seems to allow chaining up multiple commands to execute in succession 
(assuming they're not NCQ)..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

