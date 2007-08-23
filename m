From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: ATA_PIIX + SATA_MV -> kernel ate my HDD
Date: Thu, 23 Aug 2007 17:38:12 +0200
Message-ID: <46CDA9E4.5040809@wpkg.org>
References: <46CDA37D.9070208@wpkg.org> <20070823162500.056c5630@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:43733 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758648AbXHWPi1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2007 11:38:27 -0400
In-Reply-To: <20070823162500.056c5630@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

Alan Cox schrieb:
> On Thu, 23 Aug 2007 17:10:53 +0200
> Tomasz Chmielewski <mangoo@wpkg.org> wrote:
> 
>> I have a device with Intel ICH4 IDE controller, and a Marvell SATA one.
>>
>> The device has one IDE and five SATA drives connected.
> 
> Whcih devices are connected to what ports ?

1x 2 GB Transcend IDE "flash disk"
5x Western Digital WDC WD4000YR-01PLB0 SATA disks

But perhaps I didn't understand your question, did you mean which SATA 
ports?


The good thing is that after a reboot, the kernel can see all five SATA 
drives...

So perhaps it was a cosmic rays or alien sabotage. I did several 
reboots, and all drives are still there.

In the past, it never happened before.

The device is locked somewhere in the server room, so no one was doing 
anything nasty to it as I restarted into the new kernel.

Hmm.


-- 
Tomasz Chmielewski
http://wpkg.org






