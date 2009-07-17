From: Tejun Heo <tj@kernel.org>
Subject: Re: Storage fixup for WDC WD1600BEVT-22ZCT0 in an MSI Wind U100 netbook
Date: Fri, 17 Jul 2009 15:27:18 +0900
Message-ID: <4A6019C6.4070005@kernel.org>
References: <20090713024418.GA11947@sage.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53136 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933903AbZGQGZM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Jul 2009 02:25:12 -0400
In-Reply-To: <20090713024418.GA11947@sage.bj.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Li, Yan" <yan.i.li@intel.com>
Cc: linux-ide@vger.kernel.org, yanli@infradead.org

Li, Yan wrote:
> Hello,
> 
> This is the storage fix up for a WDC WD1600BEVT-22ZCT0 hard drive in
> an MSI Wind U100 Netbook.  This netbook I have been using has a
> Power_On_Hours of 38h and Load_Cycle_Count of 6617 (174 cycle/h). And
> the noisy clicking sound can be heard every a few seconds.  I found
> that Power Management Level 254 is acceptable for it.
> 
> Please be noted that the "smartcrl -a" output was taken today, when
> I'd used it for a long time with Power Management Level 254/255 so the
> Load_Cycle_Count/Power_On_Hours in it doesn't reflect the status of
> it's default setting (Power Management Level 128). The
> Load_Cycle_Count/Power_On_Hours in above paragraph was recorded months
> ago without changing its default Power Management Level, thus very
> high.

Added.

> Thank you. Please call me if you need any more information.

Hehehe... this is so refreshing.  Yay, I can call!

Thanks.

-- 
tejun
