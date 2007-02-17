From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries
 CD drives
Date: Sat, 17 Feb 2007 15:36:13 -0500
Message-ID: <45D7673D.3070202@garzik.org>
References: <20070210203512.GA25586@aepfle.de> <20070210203614.GA25602@aepfle.de> <45D4E82B.7020403@garzik.org> <20070216092046.GA2572@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47881 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932784AbXBQUgU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Feb 2007 15:36:20 -0500
In-Reply-To: <20070216092046.GA2572@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Paul Mackeras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Olaf Hering wrote:
> Change the default for the built-in IDE on p610/p615/p630 from
> ide to libata. libata has better error handling and the drive can
> recover when hald does its CD media polling.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> ---
>  arch/powerpc/configs/ppc64_defconfig   |    4 ++--
>  arch/powerpc/configs/pseries_defconfig |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

ACK the patch.  I presume Paul will apply it, as its within his file 
hierarchy


