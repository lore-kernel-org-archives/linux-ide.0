From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv & pmp support
Date: Tue, 15 Apr 2008 10:03:30 -0400
Message-ID: <4804B5B2.8050504@rtr.ca>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca> <48040C82.8080503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1336 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237AbYDOODd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Apr 2008 10:03:33 -0400
In-Reply-To: <48040C82.8080503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, Mark.
> 
> Mark Lord wrote:
>> Well, I've spent much of the day porting to the new interfaces,
>> and then trying to get things working again.
..
>>
>> Do you have any recommendations on exactly what should be in
>> mv_pmp_softreset() and mv_softreset() and mv_hardreset() under this 
>> scheme?
>>
>> My basic attempt was to try this:
>>
>> No prereset or postreset handlers of any kind.
> 
> Yes.
> 
>> mv_hardreset():  as in the hardreset rework patch (yet to be picked up
>> by Jeff), plus a call to mv_select_pmp(link->ap, SATA_PMP_CTRL_PORT)
>> before the sata_link_hardreset() wrapper loop.
> 
> Yes.
> 
>> mv_softreset():
>> First do mv_select_pmp(link->ap, SATA_PMP_CTRL_PORT),
>> and then call ata_sff_softreset().
>>
>> mv_pmp_softreset():
>> First do mv_select_pmp(link->ap, link->pmp),
>> and then call ata_sff_softreset().
> 
> You can just use mv_select_pmp(link->ap, sata_srst_pmp(link)) in 
> mv_softreset() and use it for both mv_softreset() and mv_pmp_softreset().
..

?? But the ports are different, aren't they?
Or is link->


> 
>> Resets of the pmp ports always fail with SRST failed (errno=-16).
> 
> Hmm... That's -EBUSY.  I'll continue on the reply of the other mail.
> 

