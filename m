From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] libata-sff: Reenable Port Multiplier after libata-sff remodeling.
Date: Mon, 30 Aug 2010 10:19:04 -0700
Message-ID: <AANLkTi=65rZ5CBiFmU_QfgSOT8TB=AMaTxUFyaPtsYTf@mail.gmail.com>
References: <AANLkTim9daA5eoQDbtJSnMuoBOEkDV4Y_Z3GbcDxL7Rk@mail.gmail.com>
	<1283041897-4378-1-git-send-email-gwendal@google.com>
	<4C7A22CF.3090403@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:23303 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100Ab0H3RTH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2010 13:19:07 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id o7UHJ5GI018746
	for <linux-ide@vger.kernel.org>; Mon, 30 Aug 2010 10:19:06 -0700
Received: from vws14 (vws14.prod.google.com [10.241.21.142])
	by wpaz29.hot.corp.google.com with ESMTP id o7UHJ4Kw007908
	for <linux-ide@vger.kernel.org>; Mon, 30 Aug 2010 10:19:04 -0700
Received: by vws14 with SMTP id 14so6696158vws.39
        for <linux-ide@vger.kernel.org>; Mon, 30 Aug 2010 10:19:04 -0700 (PDT)
In-Reply-To: <4C7A22CF.3090403@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jeff@garzik.org, nicolas@jungers.net, linux-ide@vger.kernel.org

On Sun, Aug 29, 2010 at 2:05 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 08/29/2010 02:31 AM, Gwendal Grignou wrote:
>> Re-introduce port_task_data to hold the link on the which the curren=
t
>> request is in progress. It allows support of links behind port multi=
plier.
>>
>> Not all libata-sff is PMP compliant. Code for native BMDMA controlle=
r
>> does not take in accound PMP.
>>
>> Tested on Marvell 7042 and Sil7526.
>
> So sata_mv is using SFF state machine for PMP devices too. =A0Didn't =
see
> that coming. =A0Thanks for fixing this. =A0Can you please consider th=
e
> followings?
>
> * Make ata_sff_queue_pio_task() take a @qc (or @link if @qc can't be
> =A0used for whatever reason) and @delay, instead of taking @ap, @link
> =A0and @delay.
Done. I keep link, because qc could be reused if the command timeout
while the task is delayed.
>
> * Change ata_port->port_task_data to something more specific. =A0ie.
> =A0sff_pio_task_qc or sff_pio_task_link.
Done.

path is next.
>
> Thanks.
>
> --
> tejun
>
