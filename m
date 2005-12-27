From: Thomas Backlund <tmb@mandriva.org>
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
Date: Tue, 27 Dec 2005 18:25:42 +0200
Message-ID: <43B16B06.3000401@mandriva.org>
References: <20051204011953.GA16381@havoc.gtf.org> <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com> <43987A28.8070509@mandriva.org> <439899B6.2000302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mbox2.netikka.net ([213.250.81.203]:18153 "EHLO
	mbox2.netikka.net") by vger.kernel.org with ESMTP id S932341AbVL0QZw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Dec 2005 11:25:52 -0500
In-Reply-To: <439899B6.2000302@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Thomas Backlund wrote:
>> Richard Bollinger wrote:
>>>> ata1: BUG: SG size underflow
>>>> ata1: status=0x50 { DriveReady SeekComplete }
>>
>>
>> and onde by one the raid devices got deactivated until the full 
>> freeze...
>
>
> I think I know what's going on with the 'SG size underflow' thingy, 
> give me a few days to come up with a fix.
>
>     Jeff
>
>
>
Any news on this?
or is it already fixed ?

--
Regards

Thomas

