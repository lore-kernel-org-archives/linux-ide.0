From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: A question about NCQ
Date: Wed, 17 May 2006 11:50:34 +0800
Message-ID: <1147837835.7273.131.camel@forrest26.sh.intel.com>
References: <1147773689.7273.88.camel@forrest26.sh.intel.com>
	 <4469AE21.6000304@gmail.com>
	 <1147832470.7273.112.camel@forrest26.sh.intel.com>
	 <446A965D.4010708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21519 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751217AbWEQEBj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 00:01:39 -0400
In-Reply-To: <446A965D.4010708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Tue, 2006-05-16 at 23:19 -0400, Jeff Garzik wrote:
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
> Can you verify that /sys/bus/scsi/devices/<device>/queue_depth is 
> greater than 1?
> 
> 	Jeff
Boot with kernel supporting NCQ:
[root@napa-sdv1 ~]# cat /sys/bus/scsi/devices/0\:0\:0\:0/queue_depth
31

Boot with kernel not supporting NCQ:
[root@napa-sdv1 ~]# cat /sys/bus/scsi/devices/0\:0\:0\:0/queue_depth
1

Forrest
