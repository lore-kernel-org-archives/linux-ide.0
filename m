From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise: port is slow to respond, reset failed
Date: Mon, 3 Sep 2007 14:59:07 +0300 (EEST)
Message-ID: <47267.194.237.142.7.1188820747.squirrel@ncircle.nullnet.fi>
References: <200709030811.l838BC9a026315@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:45702 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbXICMIp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 08:08:45 -0400
In-Reply-To: <200709030811.l838BC9a026315@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@how.dk, linux-ide@vger.kernel.org, mikpe@it.uu.se


>> > Those SATAII chips really don't seem to like 3Gbps mode. Or else we're
>> > missing some critical documentation on how to make them work.
>>
>> The funny thing is: I have the exact same adapter and disks in a Dell
>> PE1800 server. This doesn't show any errors.
>>
>> Only difference is the card is in a PCI-X slot and the server is running
>> Linux 2.6.19.5.
>
> I assume the PE1800 has some Intel chipset? Which one?
> And the machine that does have problems, what chipset does it have?

I can verify that at least my Asus A7V880 motherboard which
is based on Amd Athlon (K7) & Via KT880-chipset the Promise Sata 300 TX 4
never worked without problems with high I/O together with Seagate 7200.10
disks.

> I'm actually beginning to think there's some PCI compatibility breakage
> somewhere, as I too see sata_promise working fine in some machines but
> not in others. Alas, my knowledge of PCI tweakables is close to nil.

This would not amaze me at all as there has been more than enough
compatibility problems with certain PCI-cards <-> motherboards in the past
couple of years.

Regards,
Tomi Orava



-- 


