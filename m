From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Mon, 02 Jun 2008 05:48:16 -0400
Message-ID: <4843C1E0.3080900@garzik.org>
References: <20080508161008.59361de5@appleyard>	<20080527030854.GC7515@mit.edu>	<20080527143202.4bab5bf0@appleyard>	<20080527225926.GE6843@mit.edu>	<20080527163251.04054a74@appleyard>	<20080531080015.GG5405@ucw.cz>	<4842F5A8.9020708@garzik.org>	<20080602080440.25fc663c@core>	<4843A4A7.3020809@garzik.org> <20080602092225.26db9b5b@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42423 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757133AbYFBJs0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jun 2008 05:48:26 -0400
In-Reply-To: <20080602092225.26db9b5b@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
>> The key requirement is per-port control.  Ideally via hdparm or another 
>> userspace tool, but kernel command line (module options) or sysfs would 
>> be just fine too.  And agreed, the minimal you need is simply 1/0 for 
>> the port's policy.
> 
> We don't need it per port Jeff, you are being quite silly here. Right now
> its permanently foo=0 for all ports and nobody has suffered anything too
> horrible so being able to turn it off for all ports is clearly quite
> sufficient for the neat future.

Er, huh?  foo=0 means hotplug continues to work on the unused ports. 
Nobody has suffered because we default to enabling all the goodies.

	Jeff


