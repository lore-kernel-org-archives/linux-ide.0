From: sampei02@tiscali.it
Subject: SOLVED: DriveStatusError BadCRC
Date: Wed, 10 Aug 2005 12:14:35 +0200
Message-ID: <42D7AA47000408B7@mail-5.mail.tiscali.sys>
References: <1123494857.22328.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mrqout1.tiscali.it ([195.130.225.11]:18332 "EHLO
	mrqout1.tiscali.it") by vger.kernel.org with ESMTP id S932554AbVHJKOr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Aug 2005 06:14:47 -0400
In-Reply-To: <1123494857.22328.52.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

I replaced 80 wire flat cable with another 40 wire cable.
In this way I have no errors but now UDMA mode is set to 2 value.
I'm sure that MOTHERBOARD supports UDMA ATA/33/66/100 BUS IDE ports.
What do you think ?


>-- Messaggio Originale --
>Subject: Re: DriveStatusError BadCRC
>From:	Erik Slagter <erik@slagter.name>
>To:	linux-ide@vger.kernel.org
>Date:	Mon, 08 Aug 2005 11:54:17 +0200
>
>
>On Sun, 2005-08-07 at 08:38 -0600, Eric D. Mudama wrote:
>> 51/84 indicates the crc failed on the incoming write data from your
>> system.  These failures should be very rare (on PATA), but the bumme=
r
>> is they don't have anything to do with bad blocks on the media or
>> degrading heads...
>>=20
>> What is the temperature like inside your case?  What host adapter ar=
e
>> you using?  How many drives in the system?
>
>I'd suggest trying another cable... And also a lower UDMA setting.
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



