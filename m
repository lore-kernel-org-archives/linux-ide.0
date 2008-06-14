From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Marvell 6141 on an ASUS M2N32-WS Motherboard
Date: Sat, 14 Jun 2008 20:11:23 +0400
Message-ID: <4853EDAB.4060603@wasp.net.au>
References: <484A372D.5080307@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:40517 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380AbYFNQL1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jun 2008 12:11:27 -0400
In-Reply-To: <484A372D.5080307@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Brad Campbell wrote:
> G'day all,
> 
> The archives tell of many tales of woe regarding this chip (which 
> matches my experience).
> 
> I've added the PCI ID for it into the ahci driver, and provided I only 
> use one of the ports it works (tho it's kinda slow). As per everyone 
> elses experience, if I try and read from more than one port at one time 
> the whole shooting match dies thusly..
> 
> Begin with modprobe ahci as it does not seem to support hotplug, so 
> rmmod/plug drives/modprobe
> 
> [  798.035338] ahci 0000:08:00.0: version 3.0

Is there anyone interested in looking at this? I can leave the board on my bench for as long as it 
may be of use to someone for testing. If it's a lack of documentation or other issue that means 
there is no likelihood of a fix I'll go and install it.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
