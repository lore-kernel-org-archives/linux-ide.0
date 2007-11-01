From: "jameshsu" <jameshsu@acard.com>
Subject: Re: Should be Acard ATP8620 2SATA / 1 IDE  driver
Date: Thu, 1 Nov 2007 16:47:00 +0800
Message-ID: <003701c81c63$cee89c30$6200a8c0@jameshsu>
References: <00b501c81ace$ece895f0$6200a8c0@jameshsu> <47270656.7080205@garzik.org>
Reply-To: "jameshsu" <jameshsu@acard.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 219-80-62-20.static.tfn.net.tw ([219.80.62.20]:2488 "EHLO
	Thunder.acard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbXKAIzZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2007 04:55:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, tytso@us.ibm.com, Matti Aarnio <postmaster@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, 'David Miller' <davem@davemloft.net>

Hi Jeff,

".....Is your hardware documentation public?  I can help provide a sample
driver for your hardware, or help guide your engineers in this
effort........"
 =>>>>>  Product spec is under preparation, will be provided soon.
Right after doc public, please help us to provide a sample driver in your
eralier conveniance??
This way to ensure SATA driver of this hardware will be compliance with
Linux kernel requirement.
Thanks!

James Hsu
----- Original Message -----
From: Jeff Garzik
To: jameshsu
Cc: linux-scsi@vger.kernel.org ; 'David Miller' ; James Bottomley ; Matti
Aarnio ; tytso@us.ibm.com ; IDE/ATA development list ; Andrew Morton
Sent: Tuesday, October 30, 2007 6:24 PM
Subject: Re: Should be Acard ATP8620 2SATA / 1 IDE driver


jameshsu wrote:
> Should be in TEXT/PLAIN mode. --- resend
>
> ************************
> Hello,
>
> This driver has nothing changed since last time submit.
> However recently we download 2.6.23.1 kernel and found Acard ATP8620 SATA
> driver is still not there.
> Resend this message to submit the same driver again.
> Please help Acard to build in this SATA driver with latest Linux kernel.
> If any reason not able to add in, please let us know.

We would be glad to help!

This driver is an ATA driver, which duplicates the existing SCSI<->ATA
translation code we already have.  It also fails to work around the
problems ("quirks") found in a large number of ATA devices.

As such, it would be preferred that this ATA hardware use the existing
ATA driver API.

You can see example drivers for advanced controllers such a
drivers/ata/ahci.c and drivers/ata/sata_sil24.c, which are both
FIS-based controllers with full NCQ support, hotplug support, port
multiplier support, and many others.

It is important in Linux that we do not duplicate effort by merging
drivers that duplicate the existing SCSI<->ATA translation layer, or
fail to use our existing ATA API.

Overall, we wish to avoid adding another ATA driver inside the SCSI
layer, without using the existing ATA<->SCSI code.

Is your hardware documentation public?  I can help provide a sample
driver for your hardware, or help guide your engineers in this effort.

Regards,

Jeff, the Linux ATA maintainer

