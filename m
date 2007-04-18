From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 23:22:20 +0200
Message-ID: <200704182322.20514.bzolnier@gmail.com>
References: <88SeR-5Sf-15@gated-at.bofh.it> <46265307.7060405@rtr.ca> <46265966.1040102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:24675 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992732AbXDRVMY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 17:12:24 -0400
Received: by ug-out-1314.google.com with SMTP id 44so502941uga
        for <linux-ide@vger.kernel.org>; Wed, 18 Apr 2007 14:12:22 -0700 (PDT)
In-Reply-To: <46265966.1040102@redhat.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Mark Lord <liml@rtr.ca>, Stephen.Clark@seclark.us, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, 7eggert@gmx.de, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>


On Wednesday 18 April 2007, Chuck Ebbert wrote:
> Mark Lord wrote:
> > Mark Lord wrote:
> >>
> >> With the patch applied, I don't see *any* new activity in those
> >> S.M.A.R.T.
> >> attributes over multiple hibernates (Linux "suspend-to-disk").
> > 
> > Scratch that -- operator failure.  ;)
> > The patch makes no difference over hibernates in the SMART logs.
> > 
> > It's still logging extra Power-Off_Retract_Count pegs,
> > which it DID NOT USED TO DO not so long ago.
> > 
> 
> Just to add to the fun, my problems are happening with the "old"
> IDE drivers...

The issue you are experiencing results in the same problem (disk doing
power off retract) but it has a totally different root cause - your notebook
loses power on reboot.  It is actually a hardware problem and as you have
reported the same problem is present when using "the other" OS.

I think that the issue needs to be fixed (by detecting affected notebook(s)
using DMI?) in Linux PM handling and not in IDE subsystem because:

* there may be some other hardware devices affected by the power loss
  (== they require shutdown sequence)

* the same problem will bite if somebody decides to use libata (FC7?)

Bart
