From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA port multiplier(Marvell 6121 with ahci) and Marvell 4140,
 simg 3726
Date: Fri, 29 Aug 2008 16:38:42 +0200
Message-ID: <48B809F2.7060002@kernel.org>
References: <788014650807302022j30cea641wcfe4105ac8702b8c@mail.gmail.com> <48918D52.3010404@gmail.com> <48918DD9.9050603@kernel.org> <788014650807310612x70347f8dt56ed650dc6b8c5ca@mail.gmail.com> <48926F7E.1020807@kernel.org> <48930B2E.9060604@pobox.com> <489336E0.7020409@kernel.org> <788014650808021053y5b5a8e01y62099464cc96d8a4@mail.gmail.com> <48953D42.1010408@kernel.org> <788014650808050154r7f41cb05t5d883ee043497ba5@mail.gmail.com> <48B7F969.7060600@kernel.org> <48B807AD.9020604@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42948 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbYH2OkQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 10:40:16 -0400
In-Reply-To: <48B807AD.9020604@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: khchen@synology.com, jgarzik@pobox.com, linux-ide@vger.kernel.org

Mark Lord wrote:
>>> Dmesg: hotplug-in 3726 into 6145 , and the unplug, finally plug again
>>> ata9: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
>>> ata9: irq_stat 0x02400000, PHY RDY changed
>>> ata9: hard resetting link
>>> ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> ata9.15: qc timeout (cmd 0xe4)
>>> ata9.15: failed to read PMP GSCR[0] (Emask=0x4)
>>
>> Heh.. failing PMP READs.  Doesn't look like there's anything else to do
>> than disabling it.  Will post a patch.
> ..
> 
> No kernel timestamps there, but I do wonder if somehow
> the driver is polling too soon for the PMP?
> I wonder if a short delay in there, before issuing the PMP read,
> might help (or not)?

The timeout is currently 3 secs and the timeout is mostly dependent on
the PMP device and 3726 fares off fine with < 1sec timeouts, so I don't
think it's because of short timeout.

Thanks.

-- 
tejun
