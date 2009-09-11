From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RESEND][PATCH] sata_fsl: hard and soft reset split
Date: Fri, 11 Sep 2009 02:37:44 -0400
Message-ID: <4AA9F038.6030207@garzik.org>
References: <Pine.WNT.4.64.0906291854180.2640@B00888-02.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52497 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbZIKGhv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Sep 2009 02:37:51 -0400
In-Reply-To: <Pine.WNT.4.64.0906291854180.2640@B00888-02.fsl.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ashish kalra <ashish.kalra@freescale.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On 06/29/2009 09:26 AM, ashish kalra wrote:
> Split sata_fsl_softreset() into hard and soft resets to make
> error-handling more efficient & device and PMP detection more reliable.
>
> Also includes fix for PMP support, driver tested with Sil3726, Sil4726 &
> Exar PMP controllers.
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>

can you rediff this and 'AN' support against latest upstream?

