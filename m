From: Mark Lord <mlord@pobox.com>
Subject: Re: SATA port multiplier(Marvell 6121 with ahci) and Marvell 4140,
 simg 3726
Date: Fri, 01 Aug 2008 09:10:06 -0400
Message-ID: <48930B2E.9060604@pobox.com>
References: <788014650807302022j30cea641wcfe4105ac8702b8c@mail.gmail.com>
 <48918D52.3010404@gmail.com> <48918DD9.9050603@kernel.org>
 <788014650807310612x70347f8dt56ed650dc6b8c5ca@mail.gmail.com>
 <48926F7E.1020807@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbYHANKQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 09:10:16 -0400
In-Reply-To: <48926F7E.1020807@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: khchen@synology.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> KueiHuan Chen wrote:
>>   Thanks your reply Tejun, i would try it  ^__^.
>>
>>   Before that, Could i ask a question that had you ever try to using
>> port multiplier(sil 3726 or marvel 4140) with 6121/6145
>> succefully(with ahci.c) ?
> 
> Eh.. another mistake by me.  I was talking about controllers supported
> by sata_mv.  Mark Lord worked on it and added PMP support.  AFAIK PMP
> support on 6145/6121 is yet to arrive.  Right, Mark?
..

I have exactly zero documentation on those chips,
but they are supposedly AHCI compliant.

Looking in drivers/ata/ahci.c, one can see that the chips are indeed supported,
and there the AHCI_HFLAG_NO_PMP is *not* set, so one might expect them to work
with a port-multiplier already.  ?

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
