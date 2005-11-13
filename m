From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2.6.15-rc1] libata: fix passthru for slave devices
Date: Sat, 12 Nov 2005 21:48:01 -0500
Message-ID: <4376A961.5070401@rtr.ca>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <43764904.5030309@rtr.ca> <4376788E.9010503@pobox.com> <437680BA.40707@rtr.ca> <437685F3.6080801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:10203 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751003AbVKMCsD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Nov 2005 21:48:03 -0500
In-Reply-To: <437685F3.6080801@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
> 
>> This patch forces a correct master/slave unit bit
>> when sending libata commands via SCSI passthru.
>> The bit is left as-is for ports which do not
>> support slave devices.
...
> also, I would think you'd want to ditch the ATA_FLAG_SLAVE_POSS test. 
> Otherwise userspace could pass an invalid bit through unimpeded.

No.  Since that bit is currently "undefined" for SATA,
vendors may find a use for it in vendor-specific commands.
Thus, pass it through unless the lower level drive says
that it supports SLAVES.

Cheers
