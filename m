From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 9 Apr 2009 14:08:57 +0100
Message-ID: <20090409140857.578a9146@lxorguk.ukuu.org.uk>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>
	<49DDF1EB.2060200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58400 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764262AbZDINIq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2009 09:08:46 -0400
In-Reply-To: <49DDF1EB.2060200@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

> But.. these do look rather suspiciously like sysfs attrs to me.

I'd rather any future sysfs interface actually exposed something more
meaningful. This is a legacy fixup 8)

> 
> We didn't have a sysfs in the IDE days (so Gadi added the klunky
> procfs "settings" thing for there), but we do now.
> 
> I'm happy to update hdparm to check sysfs if that's where this
> ends up, or to do almost nothing for it if we stick with the ioctls.

I'm not sure sysfs helps much anyway - you have to open the device file
and keep it open while accessing the sysfs nodes anyway (something huge
numbers of apps hopelessly fail to do so)

If you don't you have no guarantee the pci device won't be
removed/replaced and you code will go off and adjust some other
unfortunate bit of hardware.

Alan
