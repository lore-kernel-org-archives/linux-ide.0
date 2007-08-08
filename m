From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Wed, 08 Aug 2007 23:14:11 +0900
Message-ID: <46B9CFB3.6020402@gmail.com>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>	 <fa.mg6p0itaOQUo/t8deCaYpyqj6Nk@ifi.uio.no>	 <fa.RxWYL8z8KktgL8LGZ/cTB2nI1Yc@ifi.uio.no>	 <fa.AyyCtZ2yLjC5noHPHtmzn4ffhhE@ifi.uio.no>	 <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no>	 <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no> <46B7AF53.1040307@shaw.ca>	 <46B8140E.3000509@gmail.com>  <1186497925.8780.78.camel@queen.suse.de> <1186514618.5622.9.camel@nx6310> <46B9307D.3000105@gmail.com> <46B9CE79.5030307@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:13863 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934468AbXHHOOU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 10:14:20 -0400
Received: by rv-out-0910.google.com with SMTP id k20so142726rvb
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 07:14:19 -0700 (PDT)
In-Reply-To: <46B9CE79.5030307@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Michael Sedkowski <sedmich@gmail.com>, trenn@suse.de, Robert Hancock <hancockr@shaw.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>> Michael Sedkowski wrote:
>>> Dnia 07-08-2007, Wt o godzinie 03:43 +0900, Tejun Heo napisa=C5=82(=
a):
>>>> Does emergency unload count increase
>>>> after each power down?=20
>>> I think I got it.
>>> Using smartctl I've done a test and shut down, then repeted the tes=
t.
>>> The only values that where diffrent are temperatures and
>>> Hardware_ECC_Recovered which rised by 6 points.
>>> However I have no idea which of those is the "emergency count"...
>>> Full results in attachment.
>>>
>>> 192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age =20
>>> Always       -       388
>>
>> I think this is the one.  You can test it by forcefully powering off=
 the
>> machine (press power button for several secs or disconnect AC and
>> battery) and see whether the count increases.
>=20
> FWIW, Tejun, with 2.6.22, my new Seagate 160GB SATA drive (notebook)
> increments the "Power-Off_Retract_Count" on each suspend-to-RAM opera=
tion.
> It does not do any double spin-up/spin-down things though.
>=20
> What a mess.

Hmmm.. It shouldn't.  libata now issues STANDBYNOW prior to entering
STR.  Can you instrument code a bit and see whether it actually gets is=
sued?

Thanks.

--=20
tejun
