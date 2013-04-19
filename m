From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: ahci driver cannot suspend a CF card, ata_piix can
Date: Fri, 19 Apr 2013 19:29:38 +0200
Message-ID: <51717F02.8050606@pr.hu>
References: <516D3CEF.6010202@pr.hu> <51715F5C.3050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.pr.hu ([87.242.0.5]:35968 "EHLO mail.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab3DSR36 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Apr 2013 13:29:58 -0400
In-Reply-To: <51715F5C.3050502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lwe@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hi,

2013-04-19 17:14 keltez=E9ssel, Aaron Lu =EDrta:
> On 04/16/2013 07:58 PM, Boszormenyi Zoltan wrote:
>> Hi,
>>
>> The SATA interface can be switched between AHCI and legacy modes as =
usual:
>>
>> 00:1f.2 SATA controller: Intel Corporation NM10/ICH7 Family SATA
>> Controller [AHCI mode] (rev 02)
>>
>> The device attached to the SATA controller is always a CF card via a
>> SiI3811 Serial ATA to Parallel ATA Device Bridge based converter boa=
rd.
>
> Can you please attach a normal sata disk and try again with the
> controller set to AHCI mode? I suspect it may be the SiI3811 bridge t=
hat
> caused this command.
>
> Thanks,
> Aaron

Unfortunately, there's no way for me to open the box at the moment.
This particular computer is very compact and the screws are very tight.
All the interesting devices are sealed behind its touchscreen.

But: how comes that by using the ata_piix, the SUSPEND IMMEDIATE
ATA command succeeds? Is it sent at all using the legacy mode?

Thanks,
Zolt=E1n B=F6sz=F6rm=E9nyi

