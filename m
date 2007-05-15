From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: Fixing halt/shutdown for libata spindown handling
Date: Tue, 15 May 2007 10:31:44 +0000 (UTC)
Message-ID: <loom.20070515T122357-890@post.gmane.org>
References: <46492931.4080700@gentoo.org> <46496D47.9010504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44982 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbXEOKfI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 May 2007 06:35:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HnuMw-0005Wo-0C
	for linux-ide@vger.kernel.org; Tue, 15 May 2007 12:35:02 +0200
Received: from host202-185-dynamic.1-79-r.retail.telecomitalia.it ([79.1.185.202])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 12:35:01 +0200
Received: from ceztko by host202-185-dynamic.1-79-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 12:35:01 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo <htejun <at> gmail.com> writes:
> 
> > Final question: should spindown_compat be set to 0 for both shutdown and
> > reboot, or just shutdown?
> 
> It doesn't really matter.  It just needs to be set while powering down.
>  You can set it anywhere, during boot, in shutdown.
> 
> Thanks.
> 

Hibernate/suspend shall be also considered. Setting it during boot it's one time
for every poweroff conditions, but i can't say if it's the best approach.

Regards

