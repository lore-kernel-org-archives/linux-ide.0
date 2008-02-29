From: Jeff Garzik <jeff@garzik.org>
Subject: Re: devres and requesting resources
Date: Fri, 29 Feb 2008 14:25:42 -0500
Message-ID: <47C85C36.3080509@garzik.org>
References: <47C75392.3020606@garzik.org>	<20080229112651.5b2a7f6f@core>	<47C7F664.5040102@garzik.org>	<47C7FA8B.7040306@gmail.com> <20080229140106.41ccc843@core> <47C81416.1010305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51620 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752820AbYB2TZq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Feb 2008 14:25:46 -0500
In-Reply-To: <47C81416.1010305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Tejun Heo wrote:
>> How about
>>
>> 	pcim_request_all_regions()
>>
>> for the behaviour Jeff wants, simple, direct, differently named and
>> obvious what it does.
> 
> Sounds good to me.  Jeff?

Fine with me...  Naming doesn't really matter to much as simply having 
the capability, in one form or another.

	Jeff



