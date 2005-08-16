From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: UDMA modes
Date: Tue, 16 Aug 2005 09:13:25 -0600
Message-ID: <311601c9050816081331a39ac9@mail.gmail.com>
References: <1124183117.5550.58.camel@localhost.localdomain>
	 <42D7AAB8000479BA@mail-4.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.207]:8128 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965262AbVHPPN2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 11:13:28 -0400
Received: by rproxy.gmail.com with SMTP id i8so966140rne
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 08:13:25 -0700 (PDT)
In-Reply-To: <42D7AAB8000479BA@mail-4.mail.tiscali.sys>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "sampei02@tiscali.it" <sampei02@tiscali.it>
Cc: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

we'd need to see the dmesg output I am sure

On 8/16/05, sampei02@tiscali.it <sampei02@tiscali.it> wrote:
> My Maxtor Hard Disk supports UDMA <=3D 6 (133)
> How can I control BITS options in controller ? What's line command ?
> How can I verify controller is properly configured in my kernel ?
>=20
>=20
> >-- Messaggio Originale --
> >Subject: Re: UDMA modes
> >From: Erik Slagter <erik@slagter.name>
> >To: sampei02@tiscali.it
> >Cc: linux-ide@vger.kernel.org
> >Date: Tue, 16 Aug 2005 11:05:17 +0200
> >
> >
> >On Tue, 2005-08-16 at 09:02 +0200, sampei02@tiscali.it wrote:
> >> I have motherboard which supports DMA ATA 66/100/133 and I connect=
 HD
> with
> >> new 80-wire cable.
> >> I have FC3 with Kernel 2.6.9
> >> With hdparm -i /dev/hda I get:
> >>
> >> DMA modes: udma0 udma1 udma2
> >> UDMA modes: udma0 udma1 *udma2
> >>
> >> Why udma is 2 and not udma 5 ?
> >
> >Controller not explicitly supported by linux or not configured in th=
e
> >kernel? Controller needs BITS option? (see IDE config). Harddisk doe=
sn't
> >support > udma2?
> >
> >Allegato: signature.asc
> >
>=20
>=20
> __________________________________________________________________
> TISCALI ADSL 1.25 MEGA
> Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Te=
lecom
> a partire da 19,95 Euro/mese.
> Attivala entro il 31 agosto, il primo MESE =E8 GRATIS! CLICCA QUI.
> http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
