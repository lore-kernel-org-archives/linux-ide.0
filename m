From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PATA on a SATA system doing PIO not DMA
Date: Tue, 15 Aug 2006 07:10:37 -0400
Message-ID: <44E1ABAD.7070900@garzik.org>
References: <200608151354.21359.ide@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40892 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932675AbWHOLKn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Aug 2006 07:10:43 -0400
In-Reply-To: <200608151354.21359.ide@coker.com.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell Coker <ide@coker.com.au>
Cc: linux-ide@vger.kernel.org

Russell Coker wrote:
> I have a Pentium-D machine with ICH7 chipset running the 64bit version of FC5 
> that has one S-ATA disk and one P-ATA disk.  The S-ATA disk runs normally 
> giving good performance while the P-ATA disk does about 1.5MB/s (PIO).
> 
> I have the drivers loaded in the initrd (can even have the root filesystem on 
> the P-ATA disk).  The P-ATA disk in question ran at full speed on RHEL4 in a 
> 32bit Celeron machine and has run at full speed in a Pentium 4 machine 
> running FC5.
> 
> Any ideas or suggestions for tests I should perform?  Below is the relevant 
> section of dmesg output:

I bet you need to build the IDE driver into the kernel.

	Jeff



