From: Tejun Heo <htejun@gmail.com>
Subject: Re: What's needed for PMP support?
Date: Fri, 22 Feb 2008 10:57:32 +0900
Message-ID: <47BE2C0C.3020801@gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:56854 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbYBVB5l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Feb 2008 20:57:41 -0500
Received: by wx-out-0506.google.com with SMTP id h31so225257wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 21 Feb 2008 17:57:38 -0800 (PST)
In-Reply-To: <47BE1833.9090501@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>>>
>>>> The following things are needed for a LLD to support PMP.
>>> ..
>>>> I think that's about it.  Feel free to ask if something isn't clear.
>> ..
>>
>> I think we need better semantics around sata_scr_{read,write}(),
>> or more specifically
>> These need to be moved into ata_port_operations
>> so that LLDs can wrap them to properly manage
>> the host controller's global link->pmp value.
> ..
> 
> Heck, if .dev_select() took a *device* instead of a *port*
> as it's parameter, then I could probably manage it fine in there.

Heh... I never thought a PMP aware controller would use TF SRST, so what
you want to do is set pmp value in the register and calling
ata_std_softreset(), right?  I think the correct thing to do is to
separate out SRST sequence proper from ata_std_softreset() into, say,
ata_sff_SRST() and build custom softreset around it.  After all, the
problem here is the reset sequence not the SCR access.

Thanks.

-- 
tejun
