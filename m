From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Mon, 13 Apr 2009 12:32:57 -0400
Message-ID: <49E36939.2050402@garzik.org>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>	<49DDF1EB.2060200@rtr.ca> <20090409140857.578a9146@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53523 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbZDMQdD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 12:33:03 -0400
In-Reply-To: <20090409140857.578a9146@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, gwendal@google.com

Alan Cox wrote:
>> But.. these do look rather suspiciously like sysfs attrs to me.
> 
> I'd rather any future sysfs interface actually exposed something more
> meaningful. This is a legacy fixup 8)
> 
>> We didn't have a sysfs in the IDE days (so Gadi added the klunky
>> procfs "settings" thing for there), but we do now.
>>
>> I'm happy to update hdparm to check sysfs if that's where this
>> ends up, or to do almost nothing for it if we stick with the ioctls.
> 
> I'm not sure sysfs helps much anyway - you have to open the device file
> and keep it open while accessing the sysfs nodes anyway (something huge
> numbers of apps hopelessly fail to do so)

FWIW...  here is the sysfs work I referred to (in a message sent several 
days ago in this thread)...

http://lwn.net/Articles/294608/

	Jeff



