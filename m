From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv & pmp support
Date: Tue, 15 Apr 2008 10:04:21 -0400
Message-ID: <4804B5E5.1060107@rtr.ca>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca> <48040C82.8080503@gmail.com> <4804B5B2.8050504@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1339 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097AbYDOOEW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Apr 2008 10:04:22 -0400
In-Reply-To: <4804B5B2.8050504@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
..
>> You can just use mv_select_pmp(link->ap, sata_srst_pmp(link)) in 
>> mv_softreset() and use it for both mv_softreset() and mv_pmp_softreset().
> ..
> 
> ?? But the ports are different, aren't they?
> Or is link->
..

Ignore that post.. hit "send" instead of "cancel" by mistake.  :)

