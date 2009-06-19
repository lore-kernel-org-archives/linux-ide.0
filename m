From: Marc Bowes <marcbowes@gmail.com>
Subject: Re: SATA: link online but device misclassified
Date: Fri, 19 Jun 2009 11:38:15 +0200
Message-ID: <cfa4e840906190238m4cca2c73pece279bb642bfd1f@mail.gmail.com>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>
	 <4A308798.6060803@gmail.com>
	 <cfa4e840906110231u4e90eb22wbeb2d4e748c5624a@mail.gmail.com>
	 <1244746872.3998.88.camel@mulgrave.site>
	 <cfa4e840906111232i52decee3mf9ab2d0abcaa78d9@mail.gmail.com>
	 <cfa4e840906160759m31db333cr555104ca0e3c6255@mail.gmail.com>
	 <cfa4e840906160803h3364ac8aqfd78405dbcc512df@mail.gmail.com>
	 <1245165697.3965.40.camel@mulgrave.site> <4A3AEC08.4060507@gmail.com>
	 <4A3B0D49.8070802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:46651 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbZFSJiO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jun 2009 05:38:14 -0400
Received: by ewy6 with SMTP id 6so2365395ewy.37
        for <linux-ide@vger.kernel.org>; Fri, 19 Jun 2009 02:38:15 -0700 (PDT)
In-Reply-To: <4A3B0D49.8070802@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org

Hi,

Tejun, the motherboard is a Gigabyte EP45-DQ6. Attached are dmidecode
and a new dmesg.txt, as I have enabled AHCI mode.

Robert,
0a:00.0 SATA controller: JMicron Technologies, Inc. JMicron
20360/20363 AHCI Controller (rev 02)
0a:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363
AHCI Controller (rev 02)
Those are the two JMicron controllers I have. I assume you mean the
SATA one. The AHCI controller is:
00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA
AHCI Controller
I'm not sure if just that controller will be sufficient? Anyways, I
will experiment.

Thanks

On Fri, Jun 19, 2009 at 6:00 AM, Tejun Heo<htejun@gmail.com> wrote:
> Robert Hancock wrote:
>> On 06/16/2009 09:21 AM, James Bottomley wrote:
>>> On Tue, 2009-06-16 at 17:03 +0200, Marc Bowes wrote:
>>>> Sorry to bother, but this is really bugging me! I can't seem to fi=
nd
>>>> anybody
>>>> else with the same problem. What steps should I be taking to figur=
e this
>>>> out? I'm thinking I should be trying other kernel versions and/or
>>>> plugging
>>>> drives in different places. I don't think the motherboard is fault=
y,
>>>> and I
>>>> seem to be getting good speeds (~70mbs) to all four drives.
>>>
>>> Well, those are on the AHCI built in controller. The one with the s=
low
>>> response is the empty JMicron 20360/20363. =A0But why this should b=
e so,
>>> I've no idea ... it looks like the AHCI driver can't tell the phys =
are
>>> empty for some reason, which could be due to many things.
>>
>> I would suspect it's a hardware problem that we can't do much about.=
=2E
>> For some reason the controller is reporting the SATA link is online =
at
>> 3Gbps when there's actually nothing connected. We try to repeatedly
>> reset the "device" as it doesn't respond properly, until we finally =
give
>> up.
>>
>> Can you disable that JMicron controller in the BIOS somehow?
>
> It could be some storage controller hanging off there. =A0Some revisi=
ons
> of SIMG PMPs operating in raid mode keep the link online while failin=
g
> to respond to reset if the downstream ports are empty. =A0Marc, which
> motherboard are you using? =A0Can you please post the output of
> dmidecode?
>
> Thanks.
>
> --
> tejun
>
