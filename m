From: Tejun Heo <htejun@gmail.com>
Subject: Re: A question about NCQ
Date: Tue, 16 May 2006 19:49:05 +0900
Message-ID: <4469AE21.6000304@gmail.com>
References: <1147773689.7273.88.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:8939 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751762AbWEPKtJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 06:49:09 -0400
Received: by wr-out-0506.google.com with SMTP id i22so1445806wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 03:49:08 -0700 (PDT)
In-Reply-To: <1147773689.7273.88.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: linux-ide@vger.kernel.org

zhao, forrest wrote:
> Hi, Tejun
> 
> Since your NCQ patches were pushed into #upstream, I decide to compare
> the performance between with and without NCQ enabling.
> 
> But initial test result of running iozone with O_DIRECT option turned on
> didn't show the visible performance gain with NCQ. In certain cases, NCQ
> even had a worse performance than without NCQ.
> 
> So my question is in what usage case can we observe the performance gain
> with NCQ?
> 

I don't know the workload of iozone.  But NCQ shines when there are many
concurrent IOs in progress.  A good real world example would be busy
file-serving web server.  It generally helps if there are multiple IO
requests.  If iozone is single-threaded (IO-wise), try to run multiple
copies of them and compare the results.

Also, you need to pay attention to IO schedule in use, IIRC as and cfq
are heavily optimized for single-queued devices and might not show the
best performance depending on workload.  For functionality test, I
usually use deadline.  It's simpler and usually doesn't get in the way,
which, BTW, may or may not translate into better performance.

-- 
tejun
