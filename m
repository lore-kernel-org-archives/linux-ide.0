From: =?GB2312?B?0+HB1Q==?= <yulin@starsoftcomm.com>
Subject: Re: YuLin: Where can I get the newest source of sata_sis?
Date: Fri, 01 Jun 2007 12:26:22 +0800
Message-ID: <465F9FEE.7030409@starsoftcomm.com>
References: <465E92EA.2050608@starsoftcomm.com> <465F206B.1080908@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.starsoftcomm.com ([211.100.62.25]:38353 "EHLO
	mail.starsoftcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885AbXFAE0c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Jun 2007 00:26:32 -0400
In-Reply-To: <465F206B.1080908@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: linux-ide@vger.kernel.org

Uwe Koziolek =D0=B4=B5=C0:
>> hi,
>>
>> When we used 2.6.18 and 2.6.20 on ASUS sis-671 motherboard, We have =
some
>> problem: cannot find the harddisk controller.
>> In BIOS, the SATA mode is 2P+2IDE.
>>
>> The official kernel 2.6.18, 2.6.20 and new 2.6.21 does not work, i g=
et
>> some information about sata_sis 0.7.1 from you, may I get it ?
>>
>> We are so urgent, please help me.
>>
>> Thank you very much!!!!
>>    =20
> Asus is selling a P5X-MX SE motherboard with a SiS968
> southbridge. The SiS671 Northbridge is not intresting for the SATA-su=
pport.
> Currently it is only planned to support this chipset in
> AHCI-mode. You should select the AHCI mode for the SATA-ports in the
> BIOS. The ahci driver should support your board.
> kernel 2.6.20 should be sufficient.
> If this does not work, please provide the output of
> lspci -vvxxx and the selected mode for the SATA-port.
>
> regards
> Uwe Koziolek
>
>
>
>
>
>  =20
new message:
SATA harddisk mode: IDE in BIOS
Port on SATA2 on motherboard failed. Dmesg said "ata2: SATA link down
(SStatus 0 SControl 0)".
Port on SATA1 on motherboard successed, found the harddisk and partitio=
ns.

What is the difference between SATA1 port and SATA2 port on motherboard=
,
is it a number of SATA port or different SATA version?

=BA=C7=BA=C7=A1=A3


