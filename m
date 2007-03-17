From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sat, 17 Mar 2007 18:51:51 +0800
Message-ID: <45FBC847.6010400@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <45F8C3E1.3080805@tw.ibm.com> <45F9460E.7020701@gmail.com> <45F98343.3060703@tw.ibm.com> <45FA6E8A.5070507@gmail.com> <45FAB270.8090909@tw.ibm.com> <45FB1C24.1000502@gmail.com> <45FB5F83.6070409@tw.ibm.com> <45FBB04F.7020102@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:40597 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965131AbXCQKwC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 06:52:02 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l2HAoQWq010910
	for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 06:50:26 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2HAq1Xi062910
	for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 04:52:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2HAq1Bb004029
	for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 04:52:01 -0600
In-Reply-To: <45FBB04F.7020102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

YUP wrote:
> Hi Albert,
> 
> I confirm that windows can read data from this drive. Autoplay works
> too. Even more, after I inserted dist into cdrom drive nero-info showed
> speed 52X:
> 
> Drive Information
> ------------------
> Drive                      : E-IDE    CD-ROM 56X/AKH
> Type                       : CD-ROM Drive
> Firmware Version           : A80
> Buffer Size                : 192 KB
> Date                       : ?
> Serial Number
> Vendor Specific            :
> Drive Letter               : D:\
> Location                   : 1:1
> Mechanism                  : Tray
> Read Speed                 : 52 , 40 , 32 , 24 , 16 , 8 , 4  X
> Write Speed                :  n/a
> 
> Read CD Text               : No
> Return C2 Pointers         : No
> Read CD-R                  : Yes
> Read CD-RW                 : Yes
> Read DVD-ROM               : No
> Read DVD-RAM               : No
> Read DVD-R                 : No
> Read DVD-RW                : No
> Read DVD-R DL              : No
> Read DVD+R                 : No
> Read DVD+RW                : No
> Read DVD+R DL              : No
> Read BD-ROM                : No
> Read BD-R                  : No
> Read BD-RE                 : No
> Read HD DVD-ROM            : No
> Read HD DVD-R              : No
> Read HD DVD-RW             : No
> Read HD-BURN               : No
> Read Digital Audio         : Yes
> Read CD+G                  : No
> Read VideoCD               : Yes
> 
> I tried to start linux box with inserted cd into drive but it didn't help.
> 

I don't know how windows works with it? Maybe uses polling to deal
with the lost irq?

Could you please keep the AOpen drive connected to the Promise adapter,
disconnect the HP drive from the Intel controller,
apply the attached patch, together with the previous debug patch and
{ "CD-ROM 56X/AKH", NULL,    ATA_HORKAGE_NODMA } DMA blacklist, and see if it helps.

Thanks.

--
albert

--- linux-2.6.20.3-ori/drivers/ata/pata_pdc2027x.c	2007-03-14 02:27:08.000000000 +0800
+++ linux-2.6.20.3-mod/drivers/ata/pata_pdc2027x.c	2007-03-17 18:40:49.000000000 +0800
@@ -214,7 +214,7 @@ static struct ata_port_info pdc2027x_por
 	{
 		.sht		= &pdc2027x_sht,
 		.flags		= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
-		                  ATA_FLAG_MMIO,
+		                  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5, /* udma0-5 */
@@ -224,7 +224,7 @@ static struct ata_port_info pdc2027x_por
 	{
 		.sht		= &pdc2027x_sht,
 		.flags		= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
-                        	  ATA_FLAG_MMIO,
+                        	  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6, /* udma0-6 */

