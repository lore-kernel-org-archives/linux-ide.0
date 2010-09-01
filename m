From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-sff: Reenable Port Multiplier after libata-sff
 remodeling.
Date: Wed, 01 Sep 2010 10:21:47 +0200
Message-ID: <4C7E0D1B.5060703@kernel.org>
References: <4C7A22CF.3090403@kernel.org>	<1283188678-1696-1-git-send-email-gwendal@google.com>	<4C7CB7A0.3000003@kernel.org> <AANLkTimhfcJ-OkZ3wcnuTeXF_bJRQP8uUzOpkMsOSnTE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55787 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205Ab0IAIWU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Sep 2010 04:22:20 -0400
In-Reply-To: <AANLkTimhfcJ-OkZ3wcnuTeXF_bJRQP8uUzOpkMsOSnTE@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: jeff@garzik.org, nicolas@jungers.net, linux-ide@vger.kernel.org

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
