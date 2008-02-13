From: Dirk GOUDERS <hank@et.bocholt.fh-gelsenkirchen.de>
Subject: Re: [discuss] "ide=reverse" do we still need this?
Date: Wed, 13 Feb 2008 21:00:15 +0100
Message-ID: <3138.1202932815@sora.hank.home>
References: <20080213001506.GA13933@kroah.com> <1237.1202889295@sora.hank.home> <20080213082643.GB14098@kroah.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alice.et.bocholt.fh-gelsenkirchen.de ([193.175.197.63]:34652
	"EHLO alice.et.bocholt.fh-gelsenkirchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755404AbYBMUBV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 15:01:21 -0500
In-reply-to: <20080213082643.GB14098@kroah.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: bzolnier@gmail.com, muli@il.ibm.com, discuss@x86-64.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jdmason@kudzu.us, linux-pci@atrey.karlin.mff.cuni.cz


> Hm, so, to summarize:
>   - you needed this option many years ago to get a box to work properly
>   - you don't need this today
> 
> So, if the option went away, you would not be inconvenienced?

After having reanimated the old system and after comments of other
persons I would not be inconvenienced if the option went away.

The system indeed did not boot correctly without that option, because
the disks appeared in a wrong order.  On the other hand, I was able to
(re)install bootloaders (grub as well as lilo) and after that did not
need the option any more.  Unfortunately, after that I was not able to
reproduce the initial situation where the option was needed.

Dirk
