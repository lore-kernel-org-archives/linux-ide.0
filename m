From: infernix <infernix@infernix.net>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 23 Jan 2010 15:13:20 +0100
Message-ID: <4B5B0400.6020306@infernix.net>
References: <4B591D61.8030003@infernix.net>	<4B593128.1040104@gmail.com>	<4B59A0CD.4000801@infernix.net>	<4B5A4F7A.4040709@gmail.com>	<4B5A5F09.1070300@infernix.net>	<20100123101457.7f8cbb3f@lxorguk.ukuu.org.uk>	<4B5AF4DF.4020100@infernix.net> <20100123133831.7f24ae95@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dx.infernix.net ([83.96.151.193]:35690 "EHLO dx.infernix.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850Ab0AWON1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jan 2010 09:13:27 -0500
In-Reply-To: <20100123133831.7f24ae95@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On 23/01/10 14:38, Alan Cox wrote:
>> PATA_LEGACY Depends on: ATA [=3Dy]&&  ATA_SFF [=3Dy]&&  ISA [=3Dn]&&
>> EXPERIMENTAL [=3Dy]                                            =E2=94=
=82
>>
>> So I have to turn on ISA for it to build. But that's not possible on
>> x86_64 because it depends on X86_32. I'll try a 32bit build later, b=
ut
>> I'd really like to be able to stay on x86_64. Is there a workaround?
>
> Remove the&&  ISA in Kconfig - that's bogus.

Aha. I'll try that later tonight, have some errands to run now.

>> That would make me think it's actually wired to the ICH. Maybe also =
to
>> the LPC bus but I'm not knowledgeable enough to know if thats even p=
ossible.
>
> I'm not sure what occurs if you set up the address decode on the ICH =
for
> the port and then hide it. Seems a strange thing to do but it might b=
e
> the case, and if so we can probably add a Linux quirk based on the DM=
I
> data to unhide it.

Right, so I totally forgot to post the link to that data :)

You can find full dmidecode at http://dx.infernix.net/ss4200/, includin=
g=20
dmesg in both enhanced and compatible mode.

Thanks :)
