From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/3] libata: make ata_device and ata_port use unsigned
 int xfer_mask
Date: Fri, 17 Feb 2006 00:01:32 +0900
Message-ID: <43F493CC.1000703@gmail.com>
References: <11400989462545-git-send-email-htejun@gmail.com> <1140100329.28094.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:17452 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932532AbWBPPC3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2006 10:02:29 -0500
Received: by wproxy.gmail.com with SMTP id i3so378670wra
        for <linux-ide@vger.kernel.org>; Thu, 16 Feb 2006 07:02:28 -0800 (PST)
In-Reply-To: <1140100329.28094.17.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, albertcc@tw.ibm.com, bzolnier@gmail.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Iau, 2006-02-16 at 23:09 +0900, Tejun Heo wrote:
> 
>>This change removes simplifies code in libata-core and makes
>>integration of later EH speed-down and per-device trasnfer mode
>>configuration easier.  This patch does not change any behavior.
> 
> 
> It also makes all the drive code extremely ugly and non-obvious.
> 
> We replace clear code like
> 
> 	speed = dev->pio_mode;
> 
> with
> 
>        speed = ata_xfer_mask2mode(adev->xfer_mask, ATA_SHIFT_PIO);
> 
> I don't think that is exactly an improvement. The replacement of clear
> easy to read values in the tables with macros that are convoluted and so
> long winded you've even used defines everywhere to avoid repeatign them
> is not an improvement either

I think it's better to use such XFER_MASK macros than repeating numeric
values if it's used multiple times with or without this change.

> I'm definitely opposed to this gross uglification of the libata API.
> Keep libata clean for driver writers because we have a lot of drivers
> which will be written by non-experts and a single core which is
> maintained entirely by smart people.

Yeap, point taken.  It does make code uglier for lower level drivers
although it helps cleaning up libata core layer.  I'll try to clean up
core layer without changing low level driver API.

Thanks for the comment.

-- 
tejun
