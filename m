From: Tomas Kindl <supp@kpo.zcu.cz>
Subject: Re: Fwd: confusion about libata.force=80c
Date: Wed, 12 Nov 2008 15:39:56 +0000 (UTC)
Message-ID: <loom.20081112T153626-485@post.gmane.org>
References: <57947bf80805141120v615ef957g323114637d171f0a@mail.gmail.com> <57947bf80805200222j19efa2d2n7ff89fe026745ba1@mail.gmail.com> <4833B9B5.7060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:39392 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbYKORuF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Nov 2008 12:50:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1L1PHX-0001sS-3K
	for linux-ide@vger.kernel.org; Sat, 15 Nov 2008 17:50:03 +0000
Received: from 130-71-207-85.zapcechy.adsl-llu.static.bluetone.cz ([85.207.71.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 15 Nov 2008 17:50:03 +0000
Received: from supp by 130-71-207-85.zapcechy.adsl-llu.static.bluetone.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 15 Nov 2008 17:50:03 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo <htejun <at> gmail.com> writes:

> > 
> > Is force=80c what I want? Should it work?
> 
> It should but is overridden by device side cable detection upto 2.6.25. 
>   2.6.26 will have it fixed.  force=udma66 should work.
> 

Hi, I get same error (Unknown boot option `libata.force=3:1.5': ignoring
) although I am trying it on 2.6.27.4 (MDV flavor - but still).

Any help? 

Thanks...




