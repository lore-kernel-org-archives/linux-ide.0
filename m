From: "Mahajan Vivek-B08308" <B08308@freescale.com>
Subject: RE: [PATCH 1/1] ata/sata_sil24: MSI support, disabled by default
Date: Tue, 17 Nov 2009 15:11:25 +0530
Message-ID: <F2F605B667B24B489C904986E0D60A08012220BC@zin33exm23.fsl.freescale.net>
References: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com> <da824cf30911160937l38651a44sc25a3315efd24aea@mail.gmail.com> <F2F605B667B24B489C904986E0D60A08012220A2@zin33exm23.fsl.freescale.net> <4B0253CF.3090506@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:49378 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbZKQJkq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 04:40:46 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id nAH9epeE015549
	for <linux-ide@vger.kernel.org>; Tue, 17 Nov 2009 02:40:52 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net [10.232.192.22])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nAH9eoKG001879
	for <linux-ide@vger.kernel.org>; Tue, 17 Nov 2009 03:40:52 -0600 (CST)
Content-class: urn:content-classes:message
In-Reply-To: <4B0253CF.3090506@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Grant Grundler <grundler@google.com>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

> From: Jeff Garzik [mailto:jeff@garzik.org] 
> Sent: Tuesday, November 17, 2009 1:12 PM
> > In this case "msi" is supposed to be passed via insmod and not via 
> > kernel cmdline. If the driver is built-in the kernel, then force 
> > sata_sil24_msi = 1 in the driver to enable it.
> 
> First, the original patch was just fine, and it was applied.  
> You should have received email confirmation of this already.

Yes, I did.

> Second, all module options are available on the kernel 
> command line, when a module is built into the kernel.  You 
> supply a module name prefix to each module option, on the 
> kernel command line.

Correct, sata_sil24.msi enables it.

> 
> 	Jeff

Thanks,
Vivek 
