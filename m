From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Power off empty ports
Date: Sat, 5 Mar 2011 09:01:58 +0100
Message-ID: <20110305080158.GC20499@htj.dyndns.org>
References: <20110304090644.GC20499@htj.dyndns.org>
 <1299263051-3739-1-git-send-email-kristen@linux.intel.com>
 <20110304183836.GZ20499@htj.dyndns.org>
 <20110304104756.20451b33@kcaccard-MOBL3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48604 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab1CEICD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Mar 2011 03:02:03 -0500
Received: by fxm17 with SMTP id 17so2824894fxm.19
        for <linux-ide@vger.kernel.org>; Sat, 05 Mar 2011 00:02:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110304104756.20451b33@kcaccard-MOBL3>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, Mar 04, 2011 at 10:47:56AM -0800, Kristen Carlson Accardi wrote:
> > Why not just do the following?
> > 
> > 	scontrol &= ~(0x3 << 8);
> 
> because, the IPM value is meaningless if we have no devices,
> so this is a wasted operation.

What?  You're trying to save one AND operation to a value which is
already in register in libata powersave path?  That's wrong on so many
levels (it's not even a proper optimization, think about it).  Just
make it easier on the eyes.

> This change was tested on Intel's Sandy Bridge platform.  Your power
> savings will depend on how many implemented ports you have, and how
> many are not being used.  For a system I tested with which had 2 ports
> which I could turn off, I saved 300mW.

Can you please test at least on a couple different hardware and make
sure that the port can be brought back after put to sleep?  ie. Verify
that hotplug still works after min_power -> max_performance?  Also,
please add the test results in the patch description.

Thanks.

-- 
tejun
