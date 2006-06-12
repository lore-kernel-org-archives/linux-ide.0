From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v4] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Sun, 11 Jun 2006 23:38:30 -0400
Message-ID: <448CE1B6.8020706@garzik.org>
References: <1149238185.13451.86.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52096 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750776AbWFLDii (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 23:38:38 -0400
In-Reply-To: <1149238185.13451.86.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: htejun@gmail.com, liml@rtr.ca, ric@emc.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Hi, Tejun
> 
> Sorry, my brain turned dull after one-day work......
> I should have fixed that in take 3.
> 
> Thanks,
> Forrest
> 
> Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>

This looks pretty good to me.  Please send out a v5 which re-diffs 
against the latest #upstream.  The last pull from Tejun included some of 
the changes in your v4 patch (use of __scsi_add_device, etc.).

	Jeff



