From: sampei02@tiscali.it
Subject: Re: UDMA modes
Date: Tue, 16 Aug 2005 16:21:04 +0200
Message-ID: <42D7AAB8000479BA@mail-4.mail.tiscali.sys>
References: <1124183117.5550.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mrqout1.tiscali.it ([195.130.225.11]:9143 "EHLO
	mrqout1.tiscali.it") by vger.kernel.org with ESMTP id S965245AbVHPOVQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 10:21:16 -0400
In-Reply-To: <1124183117.5550.58.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

My Maxtor Hard Disk supports UDMA <=3D 6 (133)
How can I control BITS options in controller ? What's line command ?
How can I verify controller is properly configured in my kernel ?


>-- Messaggio Originale --
>Subject: Re: UDMA modes
>From: Erik Slagter <erik@slagter.name>
>To: sampei02@tiscali.it
>Cc: linux-ide@vger.kernel.org
>Date: Tue, 16 Aug 2005 11:05:17 +0200
>
>
>On Tue, 2005-08-16 at 09:02 +0200, sampei02@tiscali.it wrote:
>> I have motherboard which supports DMA ATA 66/100/133 and I connect H=
D
with
>> new 80-wire cable.
>> I have FC3 with Kernel 2.6.9
>> With hdparm -i /dev/hda I get:
>>=20
>> DMA modes: udma0 udma1 udma2
>> UDMA modes: udma0 udma1 *udma2
>>=20
>> Why udma is 2 and not udma 5 ?
>
>Controller not explicitly supported by linux or not configured in the
>kernel? Controller needs BITS option? (see IDE config). Harddisk doesn=
't
>support > udma2?
>
>Allegato: signature.asc
>


__________________________________________________________________
TISCALI ADSL 1.25 MEGA
Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Tele=
com
a partire da 19,95 Euro/mese.
Attivala entro il 31 agosto, il primo MESE =E8 GRATIS! CLICCA QUI.
http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/



