From: Ryan <rgb005@latech.edu>
Subject: Re: hot plugable?
Date: Mon, 19 Apr 2004 02:35:40 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1082360140.4083814c6250c@webmail.LaTech.edu>
References: <pan.2004.04.13.18.37.25.709554@dungeon.inka.de> <40808DBD.8060502@clanhk.org> <1082317319.4082da07a2449@webmail.LaTech.edu> <4082E38F.3000009@clanhk.org> <1082330599.40830de70a6b5@webmail.LaTech.edu> <4083223D.4050907@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from selene.LaTech.edu ([138.47.18.25]:29933 "EHLO LaTech.edu")
	by vger.kernel.org with ESMTP id S263697AbUDSHiq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Apr 2004 03:38:46 -0400
In-Reply-To: <4083223D.4050907@clanhk.org>
List-Id: linux-ide@vger.kernel.org
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: linux-ide@vger.kernel.org

> All SATA HWIF chips support hot-swap (AFAIK), however, none are 
> supported under Linux because libata does not support it.  I think this 
> is what I said originally.  For some reason, libata supports everything 
> to do with power management, and nothing to do with hot-plugging.  =(

True, that.  Hotswap is part of the SATA standard, after all.  I just hope it
won't stay that way forever...

> It seems that particular hardware has premature support under Linux.  I 
> would be worried about disk compatibility with other 
> controllers/interfaces too, though I'm sure there are methods to 
> transfer your volumes over to a new controller, it would prolong and 
> complicate in place upgrades for people doing things on the cheap.

I'm not worried about this as it's not a production-level server and downtime is
of no consequence.  I'm willing to move my data to another location in order to
recreate the array if/when the necesary support becomes available.  Of course,
not having 240gb on any one machine other than the server really does
cmoplicate things...but I know people  >8)
 
> It may take some time for the SX4 to have mature support under Linux.  
> 3Ware is the only open-driver hardware that has a driver capable of 
> hotplug that I know of, but it gives dubious performance.  I pray for 
> the day libata does hot-swap so that I don't have to standardize on any 
> slow hardware platforms for hot-swap.    I'm excited about getting the 
> twin Raptors off the PCI bus/siimage and directly onto the 
> southbridge/sata_via.

I hope to see some progress toward that end.  Supposedly Promise is offering
support to kernel developers, but since I'm not involved with any kernel
development, much less libata, I don't know for sure.  We can only take the
developers' word for it and hope  >8)

> 
> -ryan
> 

-ryan

-- 
huh?

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

