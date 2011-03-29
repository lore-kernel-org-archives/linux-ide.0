From: Tejun Heo <tj@kernel.org>
Subject: Re: PMP and Smart Enclosure ...
Date: Tue, 29 Mar 2011 10:03:21 +0200
Message-ID: <20110329080321.GG6736@htj.dyndns.org>
References: <20110322145440.GA15541@MAIL.13thfloor.at>
 <20110322152529.GB15541@MAIL.13thfloor.at>
 <20110328085211.GD16530@htj.dyndns.org>
 <20110328123623.GD25384@MAIL.13thfloor.at>
 <20110328160136.GC6736@htj.dyndns.org>
 <20110328224642.GJ25384@MAIL.13thfloor.at>
 <20110328234729.GK25384@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48592 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab1C2ID1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Mar 2011 04:03:27 -0400
Received: by fxm17 with SMTP id 17so3270626fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 29 Mar 2011 01:03:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110328234729.GK25384@MAIL.13thfloor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-ide@vger.kernel.org

On Tue, Mar 29, 2011 at 01:47:29AM +0200, Herbert Poetzl wrote:
> On Tue, Mar 29, 2011 at 12:46:42AM +0200, Herbert Poetzl wrote:
> > On Mon, Mar 28, 2011 at 06:01:36PM +0200, Tejun Heo wrote:
> >> On Mon, Mar 28, 2011 at 02:36:23PM +0200, Herbert Poetzl wrote:
> >>> sure, any specific debug options and/or config settings
> >>> you want me to use for the test?
> 
> >> CONFIG_PRINTK_TIME would be nice.
> 
> > http://vserver.13thfloor.at/Stuff/SATAPMP/dmesg_2.6.38.txt
> 
> > note that it seems to be fixed in 2.6.38.2, I'm now
> > checking 2.6.38.1 as well to narrow down what fixed
> > it ...
> 
> following up on that, already fixed in 2.6.38.1, so maybe
> 
>   libata: fix hotplug for drivers which don't implement LPM
>   commit eb0e85e36b971ec31610eda7e3ff5c11c1c44785 upstream.
> 
> fixed it?

Ooh, right.  That makes sense.  I screwed up non-AHCI drivers while
reimplementing LPM.  :-)

Thanks.

-- 
tejun
