From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET 9/9] add hotplug support
Date: Thu, 27 Apr 2006 05:29:54 -0400
Message-ID: <44508F12.8010705@pobox.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57507 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965022AbWD0JaH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 05:30:07 -0400
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hellooooo, all.
> 
> Finally, the last one.  This is the first take of add-hotplug-support
> patchset.  This patchset includes 13 patches.
> 
> #01-04	implement hotplug framework
> #05-07	implement warm plug (SCSI scan/delete callbacks)
> #08-10	hook and activate hotplug
> #11-13	add LLDD hotplug supports (PHY status change notifications)
> 
> Hotplugging is implemented as an integral part of EH.  A new EH helper
> ata_eh_hotplug() is defined which should be called after all regular
> EH is done.  LLDDs have to do very little to support hotplug.

I'm going to leave the substantive review of this patchset for the next 
time it gets resent.

Overall,

* my quick review didn't turn up any obvious problems, but that was just 
looking at each patch, not looking at the end result (big picture) at all.

* hotplug design I want to see is (also mentioned in another email):

	1a) user requests bus scan
		or
	1b) hotplug interrupt
	2) wait a bit, swallowing any 1a- or 1b-type events that
	   appear during the wait (debounce).
	3) rescan bus, revalidate device(s)

I'm careful to use "revalidate", because that covers all cases:

	- existing device goes away
	- new device appears
	- existing device "blipped", but its still there, so
	  we can keep talking to it.

