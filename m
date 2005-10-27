From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: RE: FW: hdparm ATA Security Options return errors
Date: Thu, 27 Oct 2005 12:12:25 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BF0D@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:2830 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S1751298AbVJ0TM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2005 15:12:29 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: t.schorpp@gmx.de
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

Thanks for the update.  To unfreeze a drive you can power cycle it, but
thats not going to be a viable solution for a production system.

Tim

> -----Original Message-----
> From: thomas schorpp [mailto:t.schorpp@gmx.de]
> Sent: Thursday, October 27, 2005 12:02 PM
> To: Timothy Thelin
> Cc: linux-ide@vger.kernel.org; liml@rtr.ca
> Subject: Re: FW: hdparm ATA Security Options return errors
> 
> 
> ok tim. your app works, except that no maximum security can 
> be set on my
> old 20gb seagate (max supported) ata5 on kernel
> 2.6.13.4+passthrough...2.6.14-rc5-mm and drive status error 
> handling is
> incomplete and gives one false ok message after some command...
> 
> hdparm works too now, must be an issue on unlocking with NULL 
> password i
> used for 1. test on the linux-ide list...
> 
> tested with ata5-6 seagate/ibm desktop drives.
> 
> enhanced erase not tested cause not supported by the drives.
> 
> BTW: AMI Bios here freezes ata-security on at least ide0 PM drive on
> power on without any option to turn freeze off, THATS NOT VERY NICE
> cause this FORBIDS security use, i had to test on the sil680 
> controller :(
> 
> y
> tom
> 
