From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: cleanup ata_sff_interrupt()
Date: Fri, 15 Jan 2010 12:36:08 +0900
Message-ID: <4B4FE2A8.3070002@kernel.org>
References: <4B4ECCCD.1040902@kernel.org> <4B4EEFF9.8060805@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40930 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279Ab0AODaf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jan 2010 22:30:35 -0500
In-Reply-To: <4B4EEFF9.8060805@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>

On 01/14/2010 07:20 PM, Sergei Shtylyov wrote:
>> +        qc = ata_qc_from_tag(ap, ap->link.active_tag);
>> +        if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
>>   
> 
>   () not needed around !x.

Eh... I don't know.  I personally prefer using minimum number of
parantheses but quite a few people dislike not using them when && & ||
| are mixed.  In the end, I don't think it really matters.  It's like
debating about how far the second part of a broken line should be
indented.  Many people strong opinions but in the end it doesn't
really matter.  Anyhow, if it bothers you enough to write an email
about it, I'll be happy to oblige.  :-)

Thanks.

-- 
tejun
