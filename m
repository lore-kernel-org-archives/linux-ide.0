From: Pallav Bose <pallavbose@gmail.com>
Subject: High per-request latency observed with request_queue of depth 128
Date: Wed, 15 Jun 2011 17:48:56 -0400
Message-ID: <BANLkTimc=hYatdz9EsG3qjSyQUqPWnu7oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42313 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab1FOVtQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2011 17:49:16 -0400
Received: by iwn34 with SMTP id 34so639997iwn.19
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2011 14:49:16 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jaxboe@fusionio.com
Cc: Ganesh Karuppur Rajagopalan <ganesh.kr356@gmail.com>

Hello,

I'm working on 2.6.39.1 version of the linux kernel and am trying to
achieve a balance between high throughput and low latency for my
application. I have a block device driver which composes a struct bio
and calls the make_request_fn of the device driver to create a struct
request and then add it to the request_queue. The=A0scsi_request_fn() o=
f
the device driver is finally used for servicing the request_queue. I'm
creating 10,000 requests, each of size 32KB, with destination sectors
as -- 0, 64, 128, 192, and so on. There is an artificial inter-request
delay of 150 microsec being introduced by my driver when issuing these
requests.

The value of the nr_requests parameter
(/sys/block/sdc/queue/nr_requests) has been set to 128 by default, and
nomerges equals 2 (/sys/block/sdc/queue/nomerges), thereby disabling
all merge algorithms.

On running this experiment, I find that the per-request latency is
very high -- tens of microseconds in fact.

I don't understand why this is the case. The request_queue is large
enough (128) such that get_request_wait() (called from
__make_request() should return immediately when attempting to grab a
free request. I would expect that scsi_request_fn() would immediately
start servicing the request_queue and thus freeing slots in the
request_queue for more requests to be added. In the ideal case, a
perfect pipelining scenario would be obtained -- some requests are
being serviced by the disk, some are already present in the
request_queue, and some more requests are being added to the queue.

Is there any additional batching taking place which increases the
latency, or perhaps a timer (on a per-request basis) which when fired
causes the requests to be serviced (and not otherwise)?

I recompiled the kernel after setting BLKDEV_MIN_RQ to 1 and repeated
the above experiment after setting nr_requests to 2 (the request_queue
now has a depth of 2 only.) What I observed was that the average
per-request latency dropped below 1 millisecond. However, the first
few latencies were, in fact, of the order of tens of microseconds, and
it gradually dropped below 1 millisecond; by averaging over 10,000
requests, the average dropped below 1 millisecond (around 850
microseconds to be more precise.) Those requests which had high
latencies were primarily caused by get_request_wait() calling
io_schedule() thus putting the task to sleep. This happened because
get_request() failed to grab a free request for the composed bio
(request_queue depth being only 2.)

Can someone help me explain this phenomenon? Why the average latency
per-request is very high for nr_requests =3D 128 when compared to the
case where nr_requests =3D 2?

Also note that NCQ has been enabled via the BIOS, and the queue_depth
has been set to 31; write cache has been disabled.

Thanks,
Pallav
