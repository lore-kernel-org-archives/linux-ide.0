From: Mark Lord <lkml@rtr.ca>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Wed, 08 Aug 2007 10:08:57 -0400
Message-ID: <46B9CE79.5030307@rtr.ca>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>	 <fa.mg6p0itaOQUo/t8deCaYpyqj6Nk@ifi.uio.no>	 <fa.RxWYL8z8KktgL8LGZ/cTB2nI1Yc@ifi.uio.no>	 <fa.AyyCtZ2yLjC5noHPHtmzn4ffhhE@ifi.uio.no>	 <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no>	 <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no> <46B7AF53.1040307@shaw.ca>	 <46B8140E.3000509@gmail.com>  <1186497925.8780.78.camel@queen.suse.de> <1186514618.5622.9.camel@nx6310> <46B9307D.3000105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3745 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759661AbXHHOJA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Aug 2007 10:09:00 -0400
In-Reply-To: <46B9307D.3000105@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Sedkowski <sedmich@gmail.com>, trenn@suse.de, Robert Hancock <hancockr@shaw.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

Tejun Heo wrote:
> Michael Sedkowski wrote:
>> Dnia 07-08-2007, Wt o godzinie 03:43 +0900, Tejun Heo napisa=C5=82(a=
):
>>> Does emergency unload count increase
>>> after each power down?=20
>> I think I got it.
>> Using smartctl I've done a test and shut down, then repeted the test=
=2E
>> The only values that where diffrent are temperatures and
>> Hardware_ECC_Recovered which rised by 6 points.
>> However I have no idea which of those is the "emergency count"...
>> Full results in attachment.
>>
>> 192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Al=
ways       -       388
>=20
> I think this is the one.  You can test it by forcefully powering off =
the
> machine (press power button for several secs or disconnect AC and
> battery) and see whether the count increases.

=46WIW, Tejun, with 2.6.22, my new Seagate 160GB SATA drive (notebook)
increments the "Power-Off_Retract_Count" on each suspend-to-RAM operati=
on.
It does not do any double spin-up/spin-down things though.

What a mess.

-ml

=20

