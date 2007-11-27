From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/13] libata: use PIO for misc ATAPI commands
Date: Wed, 28 Nov 2007 08:37:07 +0900
Message-ID: <474CAA23.1070400@gmail.com>
References: <11961764391983-git-send-email-htejun@gmail.com>	<11961764413291-git-send-email-htejun@gmail.com> <20071127165600.39b8c383@the-village.bc.nu> <474CA1E2.1060008@gmail.com> <474CA8DD.3040004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.177]:33510 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757819AbXK0XhP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 18:37:15 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2074212roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 15:37:14 -0800 (PST)
In-Reply-To: <474CA8DD.3040004@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

Mark Lord wrote:
> Tejun Heo wrote:
>> Alan Cox wrote:
> ..
>> Because we can't use DMA uniformly, I went the other way and tried to
>> use PIO uniformly.  Another important point is that the other OS which
>> is probably the only platform most ATAPI device vendors test against use
>> PIO for these commands.
>>
>>> - Control over the DMA/PIO strategy belongs with the driver. If we mess
>>> that up it will cost us dearly later.
>>
>> And I don't get what we'll lose.  Care to deliberate?
> ..
> 
> Mmmm.. so what happens with the various controllers that can do PIO
> using host-DMA and host-queuing ?   Dropping to *real* PIO mode can
> be quite expensive on those, especially when the channel is shared
> with a hard disk.

They continue to do PIO the way they used to do.  No reason to drop to
*real* PIO mode.  Also, as now DMA / DMA-PIO buffers have trailing drain
buffer for misc ATAPI commands, it should behave the same way as real
PIO mode to the attached drive.

-- 
tejun
