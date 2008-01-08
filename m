From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Tue, 08 Jan 2008 08:40:23 -0600
Message-ID: <47838B57.8020407@shaw.ca>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca>
 <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com>
 <4782C008.3030902@shaw.ca> <4782CB62.7040901@gmail.com>
 <4782CEF9.3040708@gmail.com> <4782DFFE.50301@shaw.ca>
 <4782E5A8.9010305@gmail.com> <4782E63E.1000606@gmail.com>
 <4782E78F.9050205@shaw.ca> <4782E912.1050204@gmail.com>
 <4783493A.7070800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:10685 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758879AbYAHOmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 09:42:08 -0500
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUB006FLY3G5K70@l-daemon> for linux-ide@vger.kernel.org; Tue,
 08 Jan 2008 07:40:28 -0700 (MST)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
 by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUB00GX4Y3GVJC0@pd2mr6so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Tue, 08 Jan 2008 07:40:28 -0700 (MST)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUB001DMY3F9510@l-daemon> for linux-ide@vger.kernel.org; Tue,
 08 Jan 2008 07:40:27 -0700 (MST)
In-reply-to: <4783493A.7070800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

Tejun Heo wrote:
> Tejun Heo wrote:
>>> [   34.466899] testing NMI watchdog ... <4>WARNING: CPU#0: NMI appears
>>> to be stuck (0->0)!
>>> [   34.555056] WARNING: CPU#1: NMI appears to be stuck (0->0)!
>> Oops, missed that.  I'll see whether there's IRQ storm going on.
> 
> I made the nv irq handler to print message every 100th time and it says
> nothing after lock up and no response to keyboard, sysrq or serial.  It
> seems like a solid lock up to me.  Anything else you want me to try out?

I assume that replugging or unplugging cables after that point doesn't 
bring it back to life?
