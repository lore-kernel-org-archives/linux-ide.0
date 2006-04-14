From: Matthieu CASTET <matthieu.castet@sagem.com>
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_libata-pata_works_on_ICH4-M?=
Date: Fri, 14 Apr 2006 08:45:36 +0200
Message-ID: <OF0E3A280E.A7782B98-ONC1257150.0024EE7D-C1257150.00252647@sagem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.sagem.com ([62.160.59.241]:8602 "EHLO mx2.sagem.com")
	by vger.kernel.org with ESMTP id S965106AbWDNGpo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Apr 2006 02:45:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>, Gabor Gombas <gombasg@sztaki.hu>, Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-ide@vger.kernel.org, linux-ide-owner@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,=20

last time I check, some hdparm flags work fine with libata hard drive b=
ut=20
not with PATA drive.

Matthieu





Mark Lord <liml@rtr.ca>

Envoy=E9 par : linux-ide-owner@vger.kernel.org
14/04/2006 00:20
Remis le : 14/04/2006 00:21

=20
        Pour :  Jan Engelhardt <jengelh@linux01.gwdg.de>
        cc :    Gabor Gombas <gombasg@sztaki.hu>, Alan Cox <alan@lxorgu=
k.ukuu.org.uk>,=20
Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,=20
linux-ide@vger.kernel.org, Linux Kernel Mailing List=20
<linux-kernel@vger.kernel.org>, (ccc : Matthieu CASTET/EXT/SAGEM)
        Objet : Re: libata-pata works on ICH4-M



=46or now, several hdparm flags work fine with libata SCSI drives.

Eg. hdparm -W1, hdparm I, ..

Sometime in the next month or two, I hope to update hdparm to use SGIO
where possible/necessary to enable most of the remaining flags to=20
function.

Cheers
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



