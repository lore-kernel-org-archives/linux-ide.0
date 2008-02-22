From: Tejun Heo <htejun@gmail.com>
Subject: Re: What's needed for PMP support?
Date: Fri, 22 Feb 2008 11:12:46 +0900
Message-ID: <47BE2F9E.5040206@gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:56901 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbYBVCMy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Feb 2008 21:12:54 -0500
Received: by wr-out-0506.google.com with SMTP id c48so389145wra.23
        for <linux-ide@vger.kernel.org>; Thu, 21 Feb 2008 18:12:52 -0800 (PST)
In-Reply-To: <47BE2DBD.9010704@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
>> Heh... I never thought a PMP aware controller would use TF SRST, so what
>> you want to do is set pmp value in the register and calling
>> ata_std_softreset(), right?  I think the correct thing to do is to
>> separate out SRST sequence proper from ata_std_softreset() into, say,
>> ata_sff_SRST() and build custom softreset around it.  After all, the
>> problem here is the reset sequence not the SCR access.
> ..
> 
> Actually, I believe the problem *is* the (pmp) SCR access.
> The same issue will return again when trying to support hotplug, for
> example.

Can you elaborate a bit?

> Any SCR access will steal the active pmp on such hosts.
> 
> I think we really do need to snoop those, somehow.

Adding ->sata_pmp_scr_read/write should do but I wanna avoid that if
possible.

Thanks.

-- 
tejun
