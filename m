From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Asus M2V-MX SE (VIA K8T890): SATA-II disk only detected as UDMA/100
Date: Thu, 23 Jun 2011 23:08:43 -0600
Message-ID: <4E041BDB.3090903@gmail.com>
References: <1308508217.4141.20.camel@mattotaupa> <1308751011.16578.36.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48160 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1FXFIs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Jun 2011 01:08:48 -0400
Received: by iwn6 with SMTP id 6so2135363iwn.19
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2011 22:08:46 -0700 (PDT)
In-Reply-To: <1308751011.16578.36.camel@mattotaupa>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org

On 06/22/2011 07:56 AM, Paul Menzel wrote:
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

The UDMA speed doesn't really make a difference with a SATA drive. The=20
transfer speed is really controlled by the SATA link speed (1.5/3/6=20
Gbps). It only really matters if there is a PATA-SATA bridge somewhere.=
=20
Some manufacturers never supported UDMA/133 so there's a behavior=20
difference between drives in that some indicate support and some don't.=
=20
The transfer speed has to be set in most cases for compatibility reason=
s=20
but it usually doesn't actually affect anything.
