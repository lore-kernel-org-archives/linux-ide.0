From: Dirk GOUDERS <hank@et.bocholt.fh-gelsenkirchen.de>
Subject: Re: [discuss] "ide=reverse" do we still need this?
Date: Wed, 13 Feb 2008 09:54:09 +0100
Message-ID: <1572.1202892849@sora.hank.home>
References: <20080213001506.GA13933@kroah.com> <1237.1202889295@sora.hank.home> <20080213082643.GB14098@kroah.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alice.et.bocholt.fh-gelsenkirchen.de ([193.175.197.63]:48487
	"EHLO alice.et.bocholt.fh-gelsenkirchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752244AbYBMIyt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 03:54:49 -0500
In-reply-to: <20080213082643.GB14098@kroah.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: bzolnier@gmail.com, muli@il.ibm.com, discuss@x86-64.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jdmason@kudzu.us, linux-pci@atrey.karlin.mff.cuni.cz


> Hm, so, to summarize:
>   - you needed this option many years ago to get a box to work properly
>   - you don't need this today

I would summarize:

    - ide=reverse solved certain problems and I am not sure if there are
      users who still need this option

> So, if the option went away, you would not be inconvenienced?

I remember that the disks of the old box are still in a drawer and today,
I will try to reanimate the system and see if grub's ability to map
drives helps to boot the system without ide=reverse.  I'll report later.

Dirk
