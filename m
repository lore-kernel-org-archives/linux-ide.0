From: "Dario Oliva" <DOliva@ARCOIDE.COM>
Subject: RE: Infinite loop on MODE-SENSE with a removable ATAPI sata device on VIA chipset
Date: Wed, 10 May 2006 10:51:10 -0400
Message-ID: <E656D53DA4B96C409683999F573A360723E553@sbs.ARCO.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 67.104.187.164.ptr.us.xo.net ([67.104.187.164]:7664 "EHLO
	ARCOIDE.COM") by vger.kernel.org with ESMTP id S1751460AbWEJOvP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 10:51:15 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] 
> Sent: Monday, May 08, 2006 7:13 PM
> To: Dario Oliva
> Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org
> Subject: Re: Infinite loop on MODE-SENSE with a removable ATAPI sata
device on VIA chipset
>
> Dario Oliva wrote:
>> Hello Mr. Garzik:
>> 
>> We have a removable, ATAPI, SATA device and we are having the 
>> following problem with Linux (kernel version 2.6.15.6). The device 
>> recieves a MODE SENSE command. After receiving this command, it is 
>> supposed to receive a 12-byte packet command, which it recieves. 
>> Afterwards there is supposed to be an IRQ, and then the data is read 
>> from the device. However, in one computer we have with a VIA chipset,

>> the device keeps getting zeroes without stopping. In other words, it 
>> gets the 12-bytes and the continues to recive bytes all of which are 
>> zero. The device never gets the IRQ, therefore it does not respond.
>> 
>> Any ideas on this?
>> 
>> Thanks in advance for any help.
>
> Please post what kind of ATAPI device you are using and the kernel
log. 
>  If possible, please change #undef ATA_DEBUG in include/linux/libata.h
to #define ATA_DEBUG prior to generate the kernel > log.
>
> --
> tejun

Attached are some kernel messeges. I ran dmesg several times and
appended the output to the attached file, so there may be some
redudancy. However some of the commands or debug lines do appear to
repeat themselves. As you requested, I changed "#undef ATA_DEBUG" to
"#define ATA_DEBUG".

As far as the device is concerned, is an unreleased product of the
company I work for. That's why I did not give a name, because we don't
have an official name yet. But like I said, it is SATA, removalbe ATAPI.
If you want/need more information let me know.

Dario
