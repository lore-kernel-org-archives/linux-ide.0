From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: A question about NCQ
Date: Wed, 17 May 2006 11:24:29 +0800
Message-ID: <1147836269.7273.127.camel@forrest26.sh.intel.com>
References: <1147773689.7273.88.camel@forrest26.sh.intel.com>
	 <4469AE21.6000304@gmail.com>
	 <1147832470.7273.112.camel@forrest26.sh.intel.com>
	 <446A8C78.2000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56913 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751202AbWEQDha (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 23:37:30 -0400
In-Reply-To: <446A8C78.2000607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, 2006-05-17 at 11:37 +0900, Tejun Heo wrote:
> zhao, forrest wrote:
> > On Tue, 2006-05-16 at 19:49 +0900, Tejun Heo wrote:
> >> I don't know the workload of iozone.  But NCQ shines when there are many
> >> concurrent IOs in progress.  A good real world example would be busy
> >> file-serving web server.  It generally helps if there are multiple IO
> >> requests.  If iozone is single-threaded (IO-wise), try to run multiple
> >> copies of them and compare the results.
> >>
> >> Also, you need to pay attention to IO schedule in use, IIRC as and cfq
> >> are heavily optimized for single-queued devices and might not show the
> >> best performance depending on workload.  For functionality test, I
> >> usually use deadline.  It's simpler and usually doesn't get in the way,
> >> which, BTW, may or may not translate into better performance.
> >>
> > Tejun,
> > 
> > I run iozone with 8 concurrent threads. From my understanding, NCQ
> > should at least provide the same throughput as non-NCQ. But the attached
> > test result showed that NCQ has the lower throughput compared with non-
> > NCQ.
> > 
> > The io scheduler is anticipatory.
> > The kernel without NCQ is 2.6.16-rc6, the kernel with NCQ is #upstream.
> > 
> > The current problem is that I don't know where the bottleneck is, block
> > I/O layer, SCSI layer, device driver layer or hardware problem......
> 
> AFAIK, anticipatory doesn't interact very well with queued devices.  Can
> you try with deadline?
> 
By using deadline, we observed the performance gain by NCQ. To avoid
jitter, I record 6 "average throughput per process" results for NCQ and
non-NCQ:

NCQ:
write    :192 204 193 190 187 197
re-write :64  64  51  61  55  72

non-NCQ:
write    :192 188 206 201 189 200
re-write :36  37  40  39  37  41

Here we observed that NCQ has a better re-write performance than non-
NCQ.

But when using anticipatory, the test result is:
NCQ:
write: 233
re-write: 197

non-NCQ:
write: 283
re-write: 332

Here we observed that anticipatory has a better performance than
deadline. Especially re-write under anticipatory has much better
performance than the one under deadline. So why users use deadline
instead of anticipatory?

Thanks,
Forrest

