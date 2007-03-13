From: Tejun Heo <htejun@gmail.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP	drive
Date: Tue, 13 Mar 2007 23:24:47 +0900
Message-ID: <45F6B42F.80004@gmail.com>
References: <45F6964D0200002D000156EC@emea5-mh.id5.novell.com>	<45F695B8.5030006@gmail.com> <20070313134231.3d1a0263@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:20955 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030376AbXCMOYz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 10:24:55 -0400
Received: by wr-out-0506.google.com with SMTP id i28so1352477wra
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 07:24:54 -0700 (PDT)
In-Reply-To: <20070313134231.3d1a0263@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stanislav Brabec <sbrabec@novell.com>, jeff@garzik.org, bzolnier@gmail.com, paul@paulbristow.net, linux-ide@vger.kernel.org

Alan Cox wrote:
>> It seems ide-floppy needs some special handlings in interrupt handling
>> too like delaying data transfer by several ticks after device indicates
>> readiness.  Apart from separate high level driver, we might have to
>> modify libata HSM implementation if we're gonna support these devices.
> 
> The data transfer delay may well be down to the DMA bug

I see.

>> Can someone more knowledgeable explain what needs to be done differently
>> from standard ATAPI for these devices?
> 
> In theory not a lot if anything. I don't have a ZIP drive but have got an
> old Iomega Clik! PCMCIA drive somewhere if you need an ide-floppy device
> Tejun.

If you've got a spare one, that would be great but otherwise I think
you're much better qualified for libata ide-floppy support. :-)

Thanks.

-- 
tejun
