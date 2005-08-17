From: sampei02@tiscali.it
Subject: Re: UDMA modes
Date: Wed, 17 Aug 2005 10:17:07 +0200
Message-ID: <42D7AAD50004A80D@mail-6.mail.tiscali.sys>
References: <311601c9050816081331a39ac9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mrqout1.tiscali.it ([195.130.225.11]:32234 "EHLO
	mrqout1.tiscali.it") by vger.kernel.org with ESMTP id S1750983AbVHQIRT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Aug 2005 04:17:19 -0400
In-Reply-To: <311601c9050816081331a39ac9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

I updated Kernel at 2.6.12-1.1372_FC3 by rpm package.

Kernel reconized Controller IDE, infact dmesg command gets:

Uniform Multi-PLatform E-IDE driver revision: 7.00alpha2
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev.40) IDE UDMA100 controller on pci0000:00:07.=
1
probing IDE interface ide0
=2E...

What do you think ?


>-- Messaggio Originale --
>Date:	Tue, 16 Aug 2005 09:13:25 -0600
>From:	"Eric D. Mudama" <edmudama@gmail.com>
>To:	"sampei02@tiscali.it" <sampei02@tiscali.it>
>Subject: Re: UDMA modes
>Cc:	Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org
>
>
>we'd need to see the dmesg output I am sure
>
>On 8/16/05, sampei02@tiscali.it <sampei02@tiscali.it> wrote:
>> My Maxtor Hard Disk supports UDMA <=3D 6 (133)
>> How can I control BITS options in controller ? What's line command ?
>> How can I verify controller is properly configured in my kernel ?
>>=20
>>=20
>> >-- Messaggio Originale --
>> >Subject: Re: UDMA modes
>> >From: Erik Slagter <erik@slagter.name>
>> >To: sampei02@tiscali.it
>> >Cc: linux-ide@vger.kernel.org
>> >Date: Tue, 16 Aug 2005 11:05:17 +0200
>> >
>> >
>> >On Tue, 2005-08-16 at 09:02 +0200, sampei02@tiscali.it wrote:
>> >> I have motherboard which supports DMA ATA 66/100/133 and I connec=
t
HD
>> with
>> >> new 80-wire cable.
>> >> I have FC3 with Kernel 2.6.9
>> >> With hdparm -i /dev/hda I get:
>> >>
>> >> DMA modes: udma0 udma1 udma2
>> >> UDMA modes: udma0 udma1 *udma2
>> >>
>> >> Why udma is 2 and not udma 5 ?
>> >
>> >Controller not explicitly supported by linux or not configured in t=
he
>> >kernel? Controller needs BITS option? (see IDE config). Harddisk do=
esn't
>> >support > udma2?
>> >
>> >Allegato: signature.asc
>> >
>>=20
>>=20
>> __________________________________________________________________
>> TISCALI ADSL 1.25 MEGA
>> Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone T=
elecom
>> a partire da 19,95 Euro/mese.
>> Attivala entro il 31 agosto, il primo MESE =E8 GRATIS! CLICCA QUI.
>> http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/
>>=20
>>=20
>>=20
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" i=
n
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


__________________________________________________________________
TISCALI ADSL 1.25 MEGA
Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Tele=
com
a partire da 19,95 Euro/mese.
Attivala entro il 31 agosto, il primo MESE =E8 GRATIS! CLICCA QUI.
http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/



