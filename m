From: Tejun Heo <htejun@gmail.com>
Subject: Re: A question about NCQ
Date: Wed, 17 May 2006 11:37:44 +0900
Message-ID: <446A8C78.2000607@gmail.com>
References: <1147773689.7273.88.camel@forrest26.sh.intel.com>	 <4469AE21.6000304@gmail.com> <1147832470.7273.112.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:10270 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751156AbWEQChu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 22:37:50 -0400
Received: by wr-out-0506.google.com with SMTP id i3so119396wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 19:37:49 -0700 (PDT)
In-Reply-To: <1147832470.7273.112.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Tue, 2006-05-16 at 19:49 +0900, Tejun Heo wrote:
>> I don't know the workload of iozone.  But NCQ shines when there are many
>> concurrent IOs in progress.  A good real world example would be busy
>> file-serving web server.  It generally helps if there are multiple IO
>> requests.  If iozone is single-threaded (IO-wise), try to run multiple
>> copies of them and compare the results.
>>
>> Also, you need to pay attention to IO schedule in use, IIRC as and cfq
>> are heavily optimized for single-queued devices and might not show the
>> best performance depending on workload.  For functionality test, I
>> usually use deadline.  It's simpler and usually doesn't get in the way,
>> which, BTW, may or may not translate into better performance.
>>
> Tejun,
> 
> I run iozone with 8 concurrent threads. From my understanding, NCQ
> should at least provide the same throughput as non-NCQ. But the attached
> test result showed that NCQ has the lower throughput compared with non-
> NCQ.
> 
> The io scheduler is anticipatory.
> The kernel without NCQ is 2.6.16-rc6, the kernel with NCQ is #upstream.
> 
> The current problem is that I don't know where the bottleneck is, block
> I/O layer, SCSI layer, device driver layer or hardware problem......

AFAIK, anticipatory doesn't interact very well with queued devices.  Can
you try with deadline?

-- 
tejun
