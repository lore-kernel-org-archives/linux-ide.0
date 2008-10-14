From: "Grant Grundler" <grundler@google.com>
Subject: Re: How to determine performance bottleneck?
Date: Tue, 14 Oct 2008 10:43:50 -0700
Message-ID: <da824cf30810141043v7cd63a7fu9d28a64976b1ecb@mail.gmail.com>
References: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>
	 <48F3D8E2.8000006@kernel.org>
	 <da824cf30810140929o4b82f69fs9a826ef880d3f462@mail.gmail.com>
	 <48F4D49D.3050602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:26212 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbYJNRoA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 13:44:00 -0400
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id m9EHhrNr022231
	for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 18:43:53 +0100
Received: from ug-out-1314.google.com (ugem2.prod.google.com [10.66.164.2])
	by zps76.corp.google.com with ESMTP id m9EHhWkR021226
	for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 10:43:51 -0700
Received: by ug-out-1314.google.com with SMTP id m2so905318uge.14
        for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 10:43:51 -0700 (PDT)
In-Reply-To: <48F4D49D.3050602@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Tue, Oct 14, 2008 at 10:19 AM, Tejun Heo <tj@kernel.org> wrote:
> Grant Grundler wrote:
>> On Mon, Oct 13, 2008 at 4:25 PM, Tejun Heo <tj@kernel.org> wrote:
>> ...
>>>> Tejun, what kind of throughput have you seen when you have been testing
>>>> the sil3132 and multipliers?
>>> That's the limit of sil3124/3132.  Dunno why but you can't go over that.
>>
>> To be clear, I understood "that" ==  ~100 MB/s
>
> It's somewhere around that.  I don't remember the exact number at the
> moment.

I know a number but I'm also burdened with an NDA.

If someone could post the output of this command:
fio-1.21 --runtime=60 --time_based --bwavgtime=5000 \
        --thread --numjobs=4 \
        -rw=read --direct=1 --iodepth=8 --ioengine=sync \
        --ioscheduler=noop \
        --bs=256k --size=256k \
        --name=port1 --filename=/dev/sdb \
        --name=port2 --filename=/dev/sdc

Fix up the --filename to be the correct /dev names.
Re-run the above with "--rw=write" and make sure the disks can be clobbered!

This will "exercise" the disk controller cache so it doesn't matter
which disk is connected.

For fun, use 4k instead of 256k to measure CPU utilization and
transaction rates.
In this case, the disk models vary alot.

...
> I asked SIMG about the issue and whether they have newer revisions which
> solve the issue.  When I know more, I'll post it on the ata wiki page.

thanks!
grant
