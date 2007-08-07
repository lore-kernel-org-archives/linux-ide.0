From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 15:56:43 +0900
Message-ID: <46B817AB.30105@gmail.com>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com>	 <1186411815.4355.7.camel@nx6310>	 <20070806150159.GC31615@khazad-dum.debian.net>	 <200708061732.03425.rjw@sisk.pl>  <46B75459.9020204@gmail.com>	 <1186424492.4355.1.camel@nx6310>  <46B76BBC.9010107@gmail.com> <1186438698.4402.6.camel@nx6310>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:29244 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947AbXHGG46 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 02:56:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2040364wah
        for <linux-ide@vger.kernel.org>; Mon, 06 Aug 2007 23:56:56 -0700 (PDT)
In-Reply-To: <1186438698.4402.6.camel@nx6310>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Sedkowski <sedmich@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

Michael Sedkowski wrote:
> Dnia 07-08-2007, Wt o godzinie 03:43 +0900, Tejun Heo napisa=C5=82(a)=
:
>> Does emergency unload count increase
>> after each power down?=20
>=20
> I think I got it.
> Using smartctl I've done a test and shut down, then repeted the test.
> The only values that where diffrent are temperatures and
> Hardware_ECC_Recovered which rised by 6 points.
> However I have no idea which of those is the "emergency count"...
> Full results in attachment.
>=20
> 192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Alw=
ays       -       388

I think this is the one.  You can test it by forcefully powering off th=
e
machine (press power button for several secs or disconnect AC and
battery) and see whether the count increases.

--=20
tejun
