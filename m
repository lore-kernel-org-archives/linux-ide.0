From: Gwendal Grignou <gwendal@google.com>
Subject: Re: sata_mv WARNING: at drivers/ata/libata-sff.c:1322
Date: Thu, 14 Jul 2011 00:19:16 -0700
Message-ID: <CAMHSBOU+XHaFn_HtDTdvPr-sHEGS9MsYgCG9dUk71hLZJDaRow@mail.gmail.com>
References: <20110626070820.GC24867@merlins.org>
	<20110626090309.GA12200@mtj.dyndns.org>
	<4E076E9E.9080400@pobox.com>
	<20110629034125.GC32153@merlins.org>
	<4E0AA1C1.6020406@pobox.com>
	<20110629050341.GB10580@merlins.org>
	<20110629150713.GG10580@merlins.org>
	<4E0B4CC7.5000601@pobox.com>
	<20110712142938.GB4347@mtj.dyndns.org>
	<CAMHSBOWrU0MRuDOvAsU-=hqZnZrRp2ry6zvYTH0M8kwXfopryQ@mail.gmail.com>
	<4E1E1F12.8040100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:53390 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab1GNHTW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2011 03:19:22 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p6E7JIXH013527
	for <linux-ide@vger.kernel.org>; Thu, 14 Jul 2011 00:19:19 -0700
Received: from ywa8 (ywa8.prod.google.com [10.192.1.8])
	by hpaq1.eem.corp.google.com with ESMTP id p6E7IxL9031248
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Thu, 14 Jul 2011 00:19:17 -0700
Received: by ywa8 with SMTP id 8so2836410ywa.38
        for <linux-ide@vger.kernel.org>; Thu, 14 Jul 2011 00:19:17 -0700 (PDT)
In-Reply-To: <4E1E1F12.8040100@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, Marc MERLIN <marc@merlins.org>, linux-ide@vger.kernel.org, Larry Li <lil@marvell.com>, hbailey@marvell.com

Mark,

How PMP support with sata_mv broken for you? I am using marvell 7042
and sil3726 and it works fine, but I am still using 2.6.36.

Tejun, Marc,

I think what happen is if a command is canceled while waiting for
sff_pio_task to fire up, the warning may happen. The following patch
should fix it. Marc, can you reproduce the problem easily?

Thanks,
Gwendal.

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 996a7a5..c24127d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1333,6 +1333,7 @@ void ata_sff_flush_pio_task(struct ata_port *ap)

        cancel_delayed_work_sync(&ap->sff_pio_task);
        ap->hsm_task_state = HSM_ST_IDLE;
+       ap->sff_pio_task_link = NULL;

        if (ata_msg_ctl(ap))
                ata_port_dbg(ap, "%s: EXIT\n", __func__);


On Wed, Jul 13, 2011 at 3:41 PM, Mark Lord <mlord@pobox.com> wrote:
> On 11-07-13 04:54 PM, Gwendal Grignou wrote:
>> I put the warning because a new pio task should not be queued while
>> another one is pending. Therefore, either sff_pio_task_link is NULL
>> [no task pending] or sff_pio_task_link is equal to the link of the
>> task [assumed to be the task in progress].
>> I must have missed something and did not cleanup sff_pio_task_link
>> properly in case of error...
> ..
>
> I wonder if any of those changes are what broke PMP support?
> I have a Marvell PMP here that used to work when I finished with sata_mv,
> but no longer works with it now.
>
> ??
> --
> Mark Lord
> Real-Time Remedies Inc.
> mlord@pobox.com
>
