From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
Subject: RE: [RESEND][PATCH] sata_fsl: hard and soft reset split
Date: Fri, 11 Sep 2009 18:51:46 +0530
Message-ID: <16444A0F3094A24C83EAB7836A12C63B37495F@zin33exm20.fsl.freescale.net>
References: <Pine.WNT.4.64.0906291854180.2640@B00888-02.fsl.freescale.net> <4AA9F038.6030207@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:47984 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbZIKNX7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Sep 2009 09:23:59 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n8BDNxoL024363
	for <linux-ide@vger.kernel.org>; Fri, 11 Sep 2009 06:24:02 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net [10.232.192.5])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8BDPfr8028093
	for <linux-ide@vger.kernel.org>; Fri, 11 Sep 2009 08:25:42 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <4AA9F038.6030207@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello Jeff,

I will do the rediff and resubmit the patch.

Thanks,
Ashish 

-----Original Message-----
From: Jeff Garzik [mailto:jeff@garzik.org] 
Sent: Friday, September 11, 2009 12:08 PM
To: Kalra Ashish-B00888
Cc: linux-ide@vger.kernel.org; linuxppc-dev@ozlabs.org
Subject: Re: [RESEND][PATCH] sata_fsl: hard and soft reset split

On 06/29/2009 09:26 AM, ashish kalra wrote:
> Split sata_fsl_softreset() into hard and soft resets to make 
> error-handling more efficient & device and PMP detection more
reliable.
>
> Also includes fix for PMP support, driver tested with Sil3726, Sil4726

> & Exar PMP controllers.
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>

can you rediff this and 'AN' support against latest upstream?


