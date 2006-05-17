From: Jeff Garzik <jeff@garzik.org>
Subject: Re: A question about NCQ
Date: Tue, 16 May 2006 23:19:57 -0400
Message-ID: <446A965D.4010708@garzik.org>
References: <1147773689.7273.88.camel@forrest26.sh.intel.com>	 <4469AE21.6000304@gmail.com> <1147832470.7273.112.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44192 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751198AbWEQDUA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 23:20:00 -0400
In-Reply-To: <1147832470.7273.112.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

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

Can you verify that /sys/bus/scsi/devices/<device>/queue_depth is 
greater than 1?

	Jeff


