From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Cable detection fixes
Date: Thu, 01 Mar 2007 20:33:17 -0500
Message-ID: <45E77EDD.3010205@garzik.org>
References: <20070301173003.5d5ab4a6@lxorguk.ukuu.org.uk> <Pine.LNX.4.64.0703011723270.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46436 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422692AbXCBBdU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Mar 2007 20:33:20 -0500
In-Reply-To: <Pine.LNX.4.64.0703011723270.12485@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Linus Torvalds wrote:
> 
> On Thu, 1 Mar 2007, Alan wrote:
>> The patch switches the identify order so that we can do the drive side
>> detection correctly. 
>>
>> Secondly we add a ->cable_detect() method called after the identify
>> sequence which allows a host to do host side detection at this point
>> should it wish, or to modify the results of the drive side identify.
> 
> Alan, sign-offs?
> 
> Jeff, should I just expect to get these things through you?

See my reply, which passed yours in-flight :)

I'm OK with all the changes, but ->cable_detect (and _nice_ cleanups) 
does not seem like 2.6.21-rc bugfix material to me.

We definitely want the IDENTIFY ordering changes, though we'll also want 
that passed through at least one more 2.6.21-rcX release before 
confidence appears.

That little change, buried in the middle of Alan's patch, changes the 
probing order for a /lot/ of devices, possibly millions, when you 
consider that it changes behavior of ata_piix (Intel SATA) as well as 
all the not-yet-default PATA controllers.

A wanted fix, but something that definitely wants a lot of public 
testing before 2.6.21 release.

	Jeff



