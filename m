From: Prashant <0xfffff0@gmail.com>
Subject: Re: spinlock recursion in scsi_end_request() (kernel 2.6.24)
Date: Thu, 20 May 2010 17:03:16 +0530
Message-ID: <AANLkTilPaI-b4IUNfUnVKahK299fujgYTXsxC1BROw0L@mail.gmail.com>
References: <AANLkTilIYz-UITAugWx08u-AvKB5gI-E1M3LORZ55wro@mail.gmail.com>
	 <4BF508C8.9050405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44932 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab0ETLdR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 07:33:17 -0400
Received: by pxi18 with SMTP id 18so1265468pxi.19
        for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 04:33:16 -0700 (PDT)
In-Reply-To: <4BF508C8.9050405@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi,

On Thu, May 20, 2010 at 3:32 PM, Tejun Heo <tj@kernel.org> wrote:
> On 05/17/2010 01:32 PM, Prashant wrote:
>> Hi,
>> I have a board with backplane for SATA disks. Sometimes when =A0I un=
plug
>> a disk while
>> IO is going on, I get following problem. Has anybody of you
>> experienced this before?
>> Sometimes spinlock owner is kblockd, sometimes it is scsi_eh.
>
> Sorry but 2.6.24 is way too ancient at this point and too much has
> changed. =A0Can you please try a recent kernel and see whether the
> problem is reproducible?
>
Okay I 'll update If I get same problem with latest kernel (will take
lot of time).

I have a question related to code which is almost same in the current k=
ernel.
I don't know whether this is the right mailing list for the following q=
uestion.

When a sata drive is unplugged, its corresponding sdev's state is set
to SDEV_OFFLINE. Now if IO requests are still comming on the same devic=
e,
They will be killed by calling scsi_kill_request().

1) scsi_kill_request does following things:
    i) Unlock request queue
    ii) Increment host_busy count
    iii) Lock request queue
    iv) Calls __scsi_done()

2) __scsi_done() does following things:
     i) set request completion data
     ii) Calls blk_completion_request()

3) blk_completion_request() does following things:
     i) Adds request->donelist to blk_cpu_done softirq queue
        and raise the softirq (which is scsi_softirq_done)

4) next sequence is:
    scsi_softirq_done >> scsi_finish_command >> scsi_device_unbusy()

5) scsi_device_unbusy() again locks the request_queue. This is the plac=
e where
    we can get into the spinlock recursion.

    Is this correct? Please correct me if something is wrong.

Thanks,
Prashant
