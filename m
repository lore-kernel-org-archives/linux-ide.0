From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ahci: imx: software workaround for phy reset issue
 in resume
Date: Wed, 16 Apr 2014 10:01:12 -0400
Message-ID: <20140416140112.GB1257@htj.dyndns.org>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
 <1397529703-21165-2-git-send-email-shawn.guo@freescale.com>
 <20140415161018.GN1863@htj.dyndns.org>
 <20140416073823.GJ2523@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:55046 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161077AbaDPOBQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 10:01:16 -0400
Received: by mail-qc0-f175.google.com with SMTP id e16so11744985qcx.6
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2014 07:01:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140416073823.GJ2523@dragon>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>

Hello,

On Wed, Apr 16, 2014 at 03:38:24PM +0800, Shawn Guo wrote:
> The hardware manual suggests that an ACK will normally be given within
> 100us.  So using msleep() will have it sleep longer than necessary for
> normal case.  Basically, we're following the suggestion from
> Documentation/timers/timers-howto.txt to use usleep_range() over
> msleep().
> 
> SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
> 	* Use usleep_range
> 
> 	- Why not msleep for (1ms - 20ms)?
> 		Explained originally here:
> 			http://lkml.org/lkml/2007/8/3/250
> 		msleep(1~20) may not do what the caller intends, and
> 		will often sleep longer (~20 ms actual sleep for any
> 		value given in the 1~20ms range). In many cases this
> 		is not the desired behavior.

But we don't care whether the minimum wait is actually 100us here, do
we?  It's a reset path.  Let's please just be simple.  msleep(1) not
actually sleeping 1ms is an implementation detail which may change in
the future.  If this were in the command execution path, sure, but not
here.

Thanks.

-- 
tejun
