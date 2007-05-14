From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Mon, 14 May 2007 11:10:09 +0200
Message-ID: <46482771.4080602@gmail.com>
References: <20070513050522.88081.qmail@web52609.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:52667 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007AbXENJKT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 05:10:19 -0400
Received: by py-out-1112.google.com with SMTP id a29so1436646pyi
        for <linux-ide@vger.kernel.org>; Mon, 14 May 2007 02:10:19 -0700 (PDT)
In-Reply-To: <20070513050522.88081.qmail@web52609.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org

Srihari Vijayaraghavan wrote:
> --- Tejun Heo <htejun@gmail.com> wrote:
>> Srihari Vijayaraghavan wrote:
>>>> Oh well, that's the price you have to pay when you 1. have a device
>>>> which can't access memory above 4G but 2. don't have IOMMU to do it for
>>>> the device.  If performance becomes problem, you can always get a
>>>> not-so-expensive external controller which can do 64.
> 
> Can the Skymaster S3132, based on Sil3132,
> (http://umart.net/au/product_info.php?cPath=21_211&products_id=106108) do 64
> bit DMA on Linux?

Yeah, sil3124/32 can do 64bit alright.

> If so, I'm happy to buy that to isolate whether the current problem is limited
> to SB600 SATA controller alone on AMD690G chipset.

I'm too.  Please let me know when you find out.  :-P

> It'd be nice if somebody from AMD/ATI could confirm the 64 bit DMA capability
> of SB600 SATA controller. (I observe a few AMD/ATI folks have been submitting
> a few patches on LKML lately, so who knows.)

Maybe you can cc the ATI person here if you know the address.

> PS: FWIW, SB600 with your ahci fix has been working fine for the past week.
> Thank you for that.

Great.

-- 
tejun
