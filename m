From: Kalra Ashish-B00888 <B00888@freescale.com>
Subject: RE: [PATCH] libata-sff: Reenable Port Multiplier after libata-sff remodeling.
Date: Wed, 1 Sep 2010 22:03:14 +0530
Message-ID: <187b01cb49f3$9cf1a042$2303d30a@fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:57126
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755898Ab0IAQfT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Sep 2010 12:35:19 -0400
Received: from mail149-va3 (localhost.localdomain [127.0.0.1])	by
 mail149-va3-R.bigfish.com (Postfix) with ESMTP id D63CE33047D	for
 <linux-ide@vger.kernel.org>; Wed,  1 Sep 2010 16:35:17 +0000 (UTC)
Received: from VA3EHSMHS028.bigfish.com (unknown [10.7.14.241])	by
 mail149-va3.bigfish.com (Postfix) with ESMTP id 6807613A8051	for
 <linux-ide@vger.kernel.org>; Wed,  1 Sep 2010 16:35:16 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o81GYxgP003941	for <linux-ide@vger.kernel.org>; Wed, 1 Sep 2010 09:35:03
 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
 [10.232.192.5])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o81Gl7E7001058	for <linux-ide@vger.kernel.org>; Wed, 1 Sep 2010 11:47:08
 -0500 (CDT)
Content-Class: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Gwendal Grignou <gwendal@google.com>
Cc: jeff@garzik.org, nicolas@jungers.net, linux-ide@vger.kernel.org



Sent from my HTC

-----Original Message-----
From: Tejun Heo <tj@kernel.org>
Sent: 01 September 2010 1:52 PM
To: Gwendal Grignou <gwendal@google.com>
Cc: jeff@garzik.org <jeff@garzik.org>; nicolas@jungers.net <nicolas@jungers.net>; linux-ide@vger.kernel.org <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] libata-sff: Reenable Port Multiplier after libata-sff remodeling.

Hello,

On 09/01/2010 01:17 AM, Gwendal Grignou wrote:
> On Tue, Aug 31, 2010 at 1:04 AM, Tejun Heo <tj@kernel.org> wrote:
>> On 08/30/2010 07:17 PM, Gwendal Grignou wrote:
>>> Keep track of the link on the which the current request is in progress.
>>> It allows support of links behind port multiplier.
>>>
>>> Not all libata-sff is PMP compliant. Code for native BMDMA controller
>>> does not take in accound PMP.
>>
>> Can you please elaborate a bit more on what broke and how this patch
>> fixes the problem?
> Before this patch, all libata-sff assumes the qc in progess is tied to
> ap->link, the host port link.
> That's fine as long as the controllers do not support port multiplier,
> which is the case of all controller inheriting ata_sff_port_ops except
> some controllers managed by sata_mv.
> Also, before the libata-ssf reorg, it did not matter, qc was given the
> sff task directly.
> 
> However, sata_mv supports port multiplier and use part of libata-sff
> to hanlde PIO commands to disks. qc sent to disk behind port
> multiplier are tight to one of element pmp_link array.
> Therefore, the part of libata-sff sata_mv exercises must be retrieve
> qc from the provided link instead of ap->link.

Heh, I meant to elaborate in the patch description. :-) Sorry about
not being clearer.

>> It would also be useful to have WARN/BUG_ON() to make sure no two
>> links try to use pio_task at the same time.  ie. Set
>> ap->sff_pio_task_link here and clear it with NULL when done and make
>> sure it's NULL before setting it.
>
> Add some WARN/BUG. I set link to NULL very early, I believe it is
> cleaner than setting it in hsm_move() itself.
> Patch after the break.

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


