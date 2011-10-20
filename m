From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] [libata]Issue SRST to Sil3726 PMP
Date: Wed, 19 Oct 2011 17:28:38 -0700
Message-ID: <CAMHSBOVAAq+f0K49QjD4ZV249BH_gQJ=UMA4OYSWOpOKpgkX6g@mail.gmail.com>
References: <4E959E1F.20001@teksavvy.com>
	<1319068962-18983-2-git-send-email-gwendal@google.com>
	<20111020000700.GT25124@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:62136 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1JTA2l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2011 20:28:41 -0400
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id p9K0Se9e008621
	for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2011 17:28:40 -0700
Received: from qadc1 (qadc1.prod.google.com [10.224.32.129])
	by hpaq12.eem.corp.google.com with ESMTP id p9K0OTuX025014
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2011 17:28:39 -0700
Received: by qadc1 with SMTP id c1so4300447qad.0
        for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2011 17:28:38 -0700 (PDT)
In-Reply-To: <20111020000700.GT25124@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: kernel@teksavvy.com, mihrcke@gmail.com, derry@high-rely.com, linux-ide@vger.kernel.org

On Wed, Oct 19, 2011 at 5:07 PM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> On Wed, Oct 19, 2011 at 05:02:42PM -0700, Gwendal Grignou wrote:
>> Reenable sending SRST to devices connected behind a Sil3726 PMP.
>> This allow staggered spinups and handles drives that spins up slowly.
>>
>> While the drives spin up, the PMP will not accept SRST.
>> Most controller reissues the reset until the drive is ready, while
>> some [Sil3124] returns an error.
>> In ata_eh_error, wait 10s before reset the ATA port and try again.
>
> While I agree with the change, the description doesn't seem too
> accurate.
>
> * The behavior change applies to all PMPs.
I just re-enable SRST for Sil3726, not the other PMPs. For the other
ones where ATA_LFLAG_NO_SRST is still set, we will not issue softreset
and therefore will not try to access the spining disk until we send
the first identify.
For the other PMP where SRST was allowed, I guess the Sil3132
controller would have offline the disks or downgrade the speed
unnecessarily.
>
> * I hope 3726 change is in a separate patch.
>
> * It waits for reset deadline which currently happens to be 10s.
That's correct.

I update the description.

Gwendal.
>
> Thanks.
>
> --
> tejun
>
