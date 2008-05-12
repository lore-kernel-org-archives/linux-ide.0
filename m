From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.24.*/2.6.25.*: attempt to access beyond end of device
Date: Mon, 12 May 2008 10:59:42 +0100
Message-ID: <20080512105942.62607f53@core>
References: <4827D626.50903@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36810 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756398AbYELKJz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 May 2008 06:09:55 -0400
In-Reply-To: <4827D626.50903@aon.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-ide@vger.kernel.org

> I tracked the problem down to this difference in the dmesg output of the 
> bootup sequences:
> 
> 2.6.24-16.30 (Ubuntu 8.04):
> 
>   ata1.00: HPA unlocked: 268435455 -> 312581808, native 312581808
>   ata1.00: ATA-8: SAMSUNG HM160HC, LQ100-10, max UDMA/100
>   ata1.00: 312581808 sectors, multi 16: LBA48
> 
> 2.6.24.7:
> 
>   ata1.00: HPA detected: current 268435455, native 312581808
>   ata1.00: ATA-8: SAMSUNG HM160HC, LQ100-10, max UDMA/100
>   ata1.00: 268435455 sectors, multi 16: LBA48

Your Ubuntu kernel is clearing the host protected area (the BIOS has
marked the end part of the disk as 'reserved' - probably for an XP
restore partition), the base one for some reason is not.

Set the boot option "libata.ignore_hpa=1". That defaults to zero
(respecting the BIOS) so that users don't accidentally blow away BIOS
partitions and restore images, except apparently Ubuntu patch it the
other way by default.

Alan

