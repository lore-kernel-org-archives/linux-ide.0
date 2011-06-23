From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Asus M2V-MX SE (VIA K8T890): SATA-II disk only detected as UDMA/100
Date: Wed, 22 Jun 2011 20:22:11 -0400
Message-ID: <4E028733.5000100@garzik.org>
References: <1308508217.4141.20.camel@mattotaupa> <1308751011.16578.36.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:65236 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758097Ab1FWAWN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jun 2011 20:22:13 -0400
Received: by qyk9 with SMTP id 9so771362qyk.19
        for <linux-ide@vger.kernel.org>; Wed, 22 Jun 2011 17:22:13 -0700 (PDT)
In-Reply-To: <1308751011.16578.36.camel@mattotaupa>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org

On 06/22/2011 09:56 AM, Paul Menzel wrote:
> Dear SATA subsystem folks,
>
>
> please keep my address in CC list since I am not subscribed.
>
> This is a reply to my message to the coreboot list [1] and I am addin=
g
> more current information to it.
>
>
> Am Sonntag, den 19.06.2011, 20:30 +0200 schrieb Paul Menzel:
>
> the ASUS M2V-MX SE HAS A VIA K8T890 chipset and the following BIOS
> version is used.
>
>>          $ sudo dmidecode
>>          [=E2=80=A6]
>>          # dmidecode 2.9
>>          SMBIOS 2.4 present.
>>          49 structures occupying 1801 bytes.
>>          Table at 0x000F0740.
>>
>>          Handle 0x0000, DMI type 0, 24 bytes
>>          BIOS Information
>>                  Vendor: American Megatrends Inc.
>>                  Version: 0304
>>                  Release Date: 10/30/2007
>>                  Address: 0xF0000
>>                  Runtime Size: 64 kB
>>                  ROM Size: 512 kB
>>          [=E2=80=A6]
>>
>> I had to replace my hard drive and bought a new SATA-II disk.
>> Unfortunately the full speed is not detected. Instead of UDMA/133 =E2=
=80=93 as
>> was used with the old SATA-I disk =E2=80=93 it is reporting UDMA/100=
=2E
>>
>>          $ uname -a
>>          Linux joe 2.6.32-5-amd64 #1 SMP Tue Mar 8 22:49:26 UTC 2011=
 x86_64 GNU/Linux
>>          $ dmesg # new SATA-II disk
>>          [=E2=80=A6]
>>          [    0.792878] ata3: SATA max UDMA/133 cmd 0xec00 ctl 0xe88=
0 bmdma 0xe400 irq 21
>>          [    0.792881] ata4: SATA max UDMA/133 cmd 0xe800 ctl 0xe48=
0 bmdma 0xe408 irq 21
>>          [=E2=80=A6]
>>          [    1.384015] ata4: SATA link up 1.5 Gbps (SStatus 123 SCo=
ntrol 300)
>>          [    1.392019] usb 2-1: new low speed USB device using uhci=
_hcd and address 2
>>          [    1.548219] ata4.00: ATA-8: WDC WD20EARS-60MVWB0, 51.0AB=
51, max UDMA/100
>>
>> Here seems to be the problematic line, that somehow the drive is
>> reporting the wrong maximum speed or the chipset does not detect it
>> correctly.

UDMA setting is a legacy of PATA, and tends to have very little=20
relevance to SATA.

I wouldn't worry about it unless you are actually measuring low=20
performance, as opposed to just looking at dmesg.

	Jeff


