From: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
Subject: unable to set udma >= 3 on ich5 on 2.6.11
Date: Mon, 20 Jun 2005 09:06:06 -0300
Message-ID: <564d96fb05062005064283caaf@mail.gmail.com>
Reply-To: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:56268 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261217AbVFTMGJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Jun 2005 08:06:09 -0400
Received: by wproxy.gmail.com with SMTP id 68so694642wra
        for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2005 05:06:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a intel 865glc motherboard. lspci shows

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra A=
TA 100
Storage Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 S=
torage
Controller (rev 02)

from the above message and from the fact that the line
"combined mode detected" does NOT appears in dmesg I assume that I am
not I am not in combined mode. Right?

In the bios config the disk (a quantum lct 30GB) is listed as having a =
80
connector cable attached and working at udma5.

Unfortunately hdparm shows the drive at udma2:
UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5

and using -X69 does not change it.

I see that someone had a similar problem in freebsd:
http://unix.derkeiler.com/Mailing-Lists/FreeBSD/hackers/2003-12/0022.ht=
ml

Maybe it is the same problem (80 conductors cable not detected by the d=
river).

Does someone has a suggestion before I start adding prinks to piix.c?  =
:)

Thanks,
Rafael =C1vila de Esp=EDndola
