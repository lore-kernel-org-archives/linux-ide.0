From: Tejun Heo <htejun@gmail.com>
Subject: Re: A question about NCQ
Date: Wed, 17 May 2006 12:54:13 +0900
Message-ID: <446A9E65.9040608@gmail.com>
References: <1147773689.7273.88.camel@forrest26.sh.intel.com>	 <4469AE21.6000304@gmail.com>	 <1147832470.7273.112.camel@forrest26.sh.intel.com>	 <446A8C78.2000607@gmail.com> <1147836269.7273.127.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:63588 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751213AbWEQDyV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 23:54:21 -0400
Received: by wr-out-0506.google.com with SMTP id 70so473628wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 20:54:20 -0700 (PDT)
In-Reply-To: <1147836269.7273.127.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>, nickpiggin@yahoo.com.au

zhao, forrest wrote:
> On Wed, 2006-05-17 at 11:37 +0900, Tejun Heo wrote:
>> zhao, forrest wrote:
>>> On Tue, 2006-05-16 at 19:49 +0900, Tejun Heo wrote:
>>>> I don't know the workload of iozone.  But NCQ shines when there are many
>>>> concurrent IOs in progress.  A good real world example would be busy
>>>> file-serving web server.  It generally helps if there are multiple IO
>>>> requests.  If iozone is single-threaded (IO-wise), try to run multiple
>>>> copies of them and compare the results.
>>>>
>>>> Also, you need to pay attention to IO schedule in use, IIRC as and cfq
>>>> are heavily optimized for single-queued devices and might not show the
>>>> best performance depending on workload.  For functionality test, I
>>>> usually use deadline.  It's simpler and usually doesn't get in the way,
>>>> which, BTW, may or may not translate into better performance.
>>>>
>>> Tejun,
>>>
>>> I run iozone with 8 concurrent threads. From my understanding, NCQ
>>> should at least provide the same throughput as non-NCQ. But the attached
>>> test result showed that NCQ has the lower throughput compared with non-
>>> NCQ.
>>>
>>> The io scheduler is anticipatory.
>>> The kernel without NCQ is 2.6.16-rc6, the kernel with NCQ is #upstream.
>>>
>>> The current problem is that I don't know where the bottleneck is, block
>>> I/O layer, SCSI layer, device driver layer or hardware problem......
>> AFAIK, anticipatory doesn't interact very well with queued devices.  Can
>> you try with deadline?
>>
> By using deadline, we observed the performance gain by NCQ. To avoid
> jitter, I record 6 "average throughput per process" results for NCQ and
> non-NCQ:
> 
> NCQ:
> write    :192 204 193 190 187 197
> re-write :64  64  51  61  55  72
> 
> non-NCQ:
> write    :192 188 206 201 189 200
> re-write :36  37  40  39  37  41
> 
> Here we observed that NCQ has a better re-write performance than non-
> NCQ.
> 
> But when using anticipatory, the test result is:
> NCQ:
> write: 233
> re-write: 197
> 
> non-NCQ:
> write: 283
> re-write: 332
> 
> Here we observed that anticipatory has a better performance than
> deadline. Especially re-write under anticipatory has much better
> performance than the one under deadline. So why users use deadline
> instead of anticipatory?

[CC'ing Jens and Nick, Hi!]

Big difference, didn't expect that.  AS seems really good at what it
does.  I think the result would be highly dependent on the workload.
The name anticipatory is originated from the fact that it delays pending
IOs in anticipation of yet to be requested IOs.  When it hits (usually
does on a lot of workloads), the induced delay is easily offset by the
reduction of seeking.  When it misses, it just wasted time waiting for
something which never came.

I use cfq for my production system mainly to listen to mp3s better and
deadline for test systems as it gives more deterministic behavior.  I
guess static web serving with large dataset will benefit from NCQ +
deadline.

Anyways, anticipatory rules, great.  I don't know why NCQ is showing
worse performance w/ AS, but I'm pretty sure it's something which can be
fixed.  Jens, Nick, any ideas?

-- 
tejun
