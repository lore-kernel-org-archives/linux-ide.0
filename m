From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 21:14:48 -0400
Message-ID: <446A7908.308@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34461 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932402AbWEQBOv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 21:14:51 -0400
In-Reply-To: <446A734A.6020504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: ric@emc.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> As another side note, command coalescing is worth experimenting with.
> 
> Might be, but I'm a bit skeptical.  We might lose more to added latency.

Yes, that's the biggest item of note.

Still, it would be worth turning on if interrupts exceed a certain 
threshold, such as 1000/second.  Each interrupt handler setup and call, 
even with PCI MSI, has a certain fixed amount overhead.  Command 
coalescing can mitigate that overhead.

	Jeff


