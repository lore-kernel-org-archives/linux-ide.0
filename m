From: Leon Woestenberg <leonw@mailcan.com>
Subject: Re: Marvell SATA for libata?
Date: Mon, 10 May 2004 08:14:14 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <409F1DB6.7050306@mailcan.com>
References: <409D84A9.1090107@mailcan.com> <409EEE42.6070201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49850 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S264537AbUEJGPd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2004 02:15:33 -0400
In-Reply-To: <409EEE42.6070201@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello Jeff,

Jeff Garzik wrote:
> Leon Woestenberg wrote:
>> Hello all, Jeff Garzik in particular,
>>
>> we have interest in having the Marvell 88sx5040 SATA controller work
>> under libata.
>>
>> Did you happen to start development for this controller, as your
>> latest libata status report seems to tell so?
>>
>> We have the Marvell datasheet available (but under NDA) as well as
>> the source code from SuperMicro and we would like to convert it to
>> the libata framework.
> 
> 
> In fact, I am working on it right now.
>
Excellent. Applying as test-bed candidate. :-)

> I also have the docs and the driver (albeit officially :)).
> 
I happen to find it at this public customer support FTP server: 
ftp://ftp.supermicro.com/driver/SATA/DAC_SATA-MV8/

which is officially for the MV8 PCI card, which has the forementioned
chip on its PCB.

> A non-queueing driver for Marvell will be fairly straightforward. Adding 
> queueing will be much more of a chore, though.
> 
That makes me wonder, what is the typical performance gain when using
any of the command queueing methods?

Regards,

Leon.
