From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/6] AHCI suspend/resume support
Date: Fri, 02 Jun 2006 11:23:41 -0700
Message-ID: <4480822D.6050300@goop.org>
References: <1149233973.13451.51.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:48822 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932569AbWFBUai (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2006 16:30:38 -0400
In-Reply-To: <1149233973.13451.51.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, lkml@rtr.ca, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Your comments and bug report are welcome.

Thanks, these patches work well for me.  Certainly I can do at least one 
suspend-resume cycle, which is a big improvement. The second suspend 
fails, but I think this is a separate issue unrelated to scsi/sata/ahci.

One other problem is a total machine lockup, which so far has only 
happened while in X, so I couldn't see any console messages.  Again, 
this might have nothing to do with storage; I'll let you know if 
anything relevant turns up.

In short: good work!

Thanks,
    J

