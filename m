From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Sun, 13 May 2007 15:05:22 +1000 (EST)
Message-ID: <20070513050522.88081.qmail@web52609.mail.re2.yahoo.com>
References: <46407C86.1010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52609.mail.re2.yahoo.com ([206.190.48.212]:40797 "HELO
	web52609.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752326AbXEMFFX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 May 2007 01:05:23 -0400
In-Reply-To: <46407C86.1010304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--- Tejun Heo <htejun@gmail.com> wrote:
> Srihari Vijayaraghavan wrote:
> >> Oh well, that's the price you have to pay when you 1. have a device
> >> which can't access memory above 4G but 2. don't have IOMMU to do it for
> >> the device.  If performance becomes problem, you can always get a
> >> not-so-expensive external controller which can do 64.

Can the Skymaster S3132, based on Sil3132,
(http://umart.net/au/product_info.php?cPath=21_211&products_id=106108) do 64
bit DMA on Linux?

If so, I'm happy to buy that to isolate whether the current problem is limited
to SB600 SATA controller alone on AMD690G chipset.

It'd be nice if somebody from AMD/ATI could confirm the 64 bit DMA capability
of SB600 SATA controller. (I observe a few AMD/ATI folks have been submitting
a few patches on LKML lately, so who knows.)

Thanks

PS: FWIW, SB600 with your ahci fix has been working fine for the past week.
Thank you for that.


      Switch to Yahoo!7 Mail: Transfer all your contacts and emails from Hotmail and other providers to Yahoo!7 Mail. http://au.docs.yahoo.com/mail/trueswitch_info.html

