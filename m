From: Mark Lord <mlord@pobox.com>
Subject: Re: sata_mv WARNING: at drivers/ata/libata-sff.c:1322
Date: Wed, 13 Jul 2011 18:41:22 -0400
Message-ID: <4E1E1F12.8040100@pobox.com>
References: <20110626070820.GC24867@merlins.org>
 <20110626090309.GA12200@mtj.dyndns.org> <4E076E9E.9080400@pobox.com>
 <20110629034125.GC32153@merlins.org> <4E0AA1C1.6020406@pobox.com>
 <20110629050341.GB10580@merlins.org> <20110629150713.GG10580@merlins.org>
 <4E0B4CC7.5000601@pobox.com> <20110712142938.GB4347@mtj.dyndns.org>
 <CAMHSBOWrU0MRuDOvAsU-=hqZnZrRp2ry6zvYTH0M8kwXfopryQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36678 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612Ab1GMWlY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Jul 2011 18:41:24 -0400
In-Reply-To: <CAMHSBOWrU0MRuDOvAsU-=hqZnZrRp2ry6zvYTH0M8kwXfopryQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Tejun Heo <tj@kernel.org>, Marc MERLIN <marc@merlins.org>, linux-ide@vger.kernel.org, Larry Li <lil@marvell.com>, hbailey@marvell.com

On 11-07-13 04:54 PM, Gwendal Grignou wrote:
> I put the warning because a new pio task should not be queued while
> another one is pending. Therefore, either sff_pio_task_link is NULL
> [no task pending] or sff_pio_task_link is equal to the link of the
> task [assumed to be the task in progress].
> I must have missed something and did not cleanup sff_pio_task_link
> properly in case of error...
..

I wonder if any of those changes are what broke PMP support?
I have a Marvell PMP here that used to work when I finished with sata_mv,
but no longer works with it now.

??
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
