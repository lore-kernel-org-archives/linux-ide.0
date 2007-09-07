From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA_PIIX - soft resetting port, port is slow to respond, machine
 "freezes" for a few seconds
Date: Fri, 07 Sep 2007 11:17:54 +0900
Message-ID: <46E0B4D2.4030600@gmail.com>
References: <46D94BBB.9080403@wpkg.org> <6b9952490709010500q2a93156cq399434a3a44a2d25@mail.gmail.com> <46D95A6F.6060808@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:9839 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbXIGCSF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 22:18:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so382955wah
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 19:18:03 -0700 (PDT)
In-Reply-To: <46D95A6F.6060808@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Joris <joris@v5.be>, Linux IDE <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Tomasz Chmielewski wrote:
> Joris schrieb:
>> Hello Tomasz,
>>
>>
>> This appears remarkably simelar to what I'm experiencing, altough I'm
>> getting that on sata ports.
>> I'm currently at a loss on what caused this, but if there's two of
>> us... ;-)
>> See: http://marc.info/?l=linux-ide&m=118812690407577&w=2
>>
>> What kind of hardware are you running?
> 
> It's a dual core Xeon.
> 
> Root filesystem starts off a 2 GB Transcend IDE flash disk, and there is
> a 4-disk RAID-10 array behind a hardware RAID, with LVM on it.
> 
> I noticed it doesn't soft reset anymore once the kernel said:
> 
> ata1.00: limiting speed to MWDMA1:PIO4

Aieee... MWDMA2 brokenness again.  cc'ing Jeff and Alan for the record.

Thanks.

-- 
tejun
