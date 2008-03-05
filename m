From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA HDD password problem
Date: Wed, 05 Mar 2008 07:30:28 -0500
Message-ID: <47CE9264.1010600@garzik.org>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43711 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756838AbYCEMad (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Mar 2008 07:30:33 -0500
In-Reply-To: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Cc: linux-ide@vger.kernel.org

Rus V. Brushkoff wrote:
> 
>     Hi,
> 
>  For example someone has laptop with enabled in BIOS HDD password 
> feature. When laptop pass POST, user enters the password, LILO trying to 
> boot the kernel, kernel send RESET to SATA drive and password need to be 
> entered again - so the kernel panics because it cant mount rootfs. How 
> this problem can be solved ? Using initrd image and entering password 
> twice is somewhat ugly. Is this the HDD manufacturer bug ? Kernel is 
> stock Linus 2.6.23, HDD is WDC WD2500BEVS-22UST0, laptop Acer Ferrari 1100.

This is definitely an under-tested area, as most people do not enable 
this feature.

Make sure libata module option 'noacpi' is disabled (0).

It sounds like a software bug, not HDD manufacturer bug, to me.

	Jeff




