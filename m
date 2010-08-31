From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] libata-sff: Reenable Port Multiplier after libata-sff remodeling.
Date: Tue, 31 Aug 2010 16:17:36 -0700
Message-ID: <AANLkTimhfcJ-OkZ3wcnuTeXF_bJRQP8uUzOpkMsOSnTE@mail.gmail.com>
References: <4C7A22CF.3090403@kernel.org>
	<1283188678-1696-1-git-send-email-gwendal@google.com>
	<4C7CB7A0.3000003@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:55150 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab0HaXRj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2010 19:17:39 -0400
Received: from wpaz9.hot.corp.google.com (wpaz9.hot.corp.google.com [172.24.198.73])
	by smtp-out.google.com with ESMTP id o7VNHcs0004346
	for <linux-ide@vger.kernel.org>; Tue, 31 Aug 2010 16:17:38 -0700
Received: from ywg4 (ywg4.prod.google.com [10.192.7.4])
	by wpaz9.hot.corp.google.com with ESMTP id o7VNHaCF016279
	for <linux-ide@vger.kernel.org>; Tue, 31 Aug 2010 16:17:37 -0700
Received: by ywg4 with SMTP id 4so870452ywg.4
        for <linux-ide@vger.kernel.org>; Tue, 31 Aug 2010 16:17:36 -0700 (PDT)
In-Reply-To: <4C7CB7A0.3000003@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jeff@garzik.org, nicolas@jungers.net, linux-ide@vger.kernel.org

On Tue, Aug 31, 2010 at 1:04 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 08/30/2010 07:17 PM, Gwendal Grignou wrote:
>> Keep track of the link on the which the current request is in progre=
ss.
>> It allows support of links behind port multiplier.
>>
>> Not all libata-sff is PMP compliant. Code for native BMDMA controlle=
r
>> does not take in accound PMP.
>
> Can you please elaborate a bit more on what broke and how this patch
> fixes the problem?
Before this patch, all libata-sff assumes the qc in progess is tied to
ap->link, the host port link.
That's fine as long as the controllers do not support port multiplier,
which is the case of all controller inheriting ata_sff_port_ops except
some controllers managed by sata_mv.
Also, before the libata-ssf reorg, it did not matter, qc was given the
sff task directly.

However, sata_mv supports port multiplier and use part of libata-sff
to hanlde PIO commands to disks. qc sent to disk behind port
multiplier are tight to one of element pmp_link array.
Therefore, the part of libata-sff sata_mv exercises must be retrieve
qc from the provided link instead of ap->link.

>
>> -void ata_sff_queue_pio_task(struct ata_port *ap, unsigned long dela=
y)
>> +void ata_sff_queue_pio_task(struct ata_link *link, unsigned long de=
lay)
>> =A0{
>> + =A0 =A0 struct ata_port *ap =3D link->ap;
>
> New line here, please.
Done
>
>> + =A0 =A0 ap->sff_pio_task_link =3D link;
>
> It would also be useful to have WARN/BUG_ON() to make sure no two
> links try to use pio_task at the same time. =A0ie. Set
> ap->sff_pio_task_link here and clear it with NULL when done and make
> sure it's NULL before setting it.
Add some WARN/BUG. I set link to NULL very early, I believe it is
cleaner than setting it in hsm_move() itself.
Patch after the break.

Gwendal.
>
> Otherwise, looks good to me.
>
> Thanks!
>
> --
> tejun
>
