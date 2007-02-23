From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] libata: add NCQ blacklist entries from Silicon Image
 Windows driver
Date: Thu, 22 Feb 2007 18:18:47 -0600
Message-ID: <45DE32E7.1010901@shaw.ca>
References: <45DD2EC9.4050403@shaw.ca> <45DD3EC7.3050801@garzik.org>
 <3A2F4CD2-EF4C-4C5D-B1B3-A9C89BA9682C@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:12115 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbXBWASw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Feb 2007 19:18:52 -0500
In-reply-to: <3A2F4CD2-EF4C-4C5D-B1B3-A9C89BA9682C@develooper.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Tejun Heo <htejun@gmail.com>, "Eric D. Mudama" <edmudama@gmail.com>

Ask Bj=F8rn Hansen wrote:
>=20
> On Feb 21, 2007, at 10:57 PM, Jeff Garzik wrote:
>=20
>>> +    /* The following blacklist entries are taken from the Windows
>>> +       driver .inf files for the Silicon Image 3124 and 3132. */
>>> +    { "Maxtor 7B250S0",    "BANC1B70",    ATA_HORKAGE_NONCQ, },
> [...]
>>
>> Do we have information that these drives fail on non-SiI controllers=
?
>=20
> At least tangentially related:
>=20
> On one of my boxes (running 2.6.18-1.2869 from Fedora) I have a coupl=
e=20
> of other Maxtor drives that didn't like NCQ.   They are on a JMicron=20
> 20360/20363 (ahci driver).  (There's also a Promise 300 TX4 card in t=
he=20
> box and an Intel ICH8 that shows up with ata_piix).
>=20
> model and (partial) firmware revision of the drives:
> Maxtor 7V300F0  VA11
> Maxtor 7B300S0  BANC
>=20
> Until I disabled NCQ I got gazillions of messages like the ones below=
=20
> and absymal performance.
>=20
>   - ask
>=20
>=20
> ata5: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0=
xf)

Sounds like those are some that we should be blacklisting as well,=20
unless Eric has a good reason why not (CCing). Can you provide the full=
=20
firmware revision strings from those drives, i.e. from "hdparm -I"?

--=20
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

