From: luca pedrielli <luca.pedrielli@barradev.it>
Subject: sata_via on MSI MS-7293 MB
Date: Thu, 11 Jan 2007 09:43:50 +0100
Message-ID: <200701110943.50988.luca.pedrielli@barradev.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.webmessenger.it ([193.70.193.55]:47576 "EHLO
	mail1a.webmessenger.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030236AbXAKIti (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 03:49:38 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


Hi Jeff,

sata_via will detect also MSI MS-7293 MB VIA VT8237 chipset?

i had to patch sata_via module in this way:

@@ -78,7 +78,7 @@
 static const struct pci_device_id svia_pci_tbl[] =3D {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
 	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },
-
+	{ 0x1106, 0x5337, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },    <-------
 	{ }	/* terminate list */
 };

Thanks.


--=20
-----------------------------------------------------------------------=
-------
Pedrielli Luca=20
Barradev Srl - Via Carlo Marx, 95 - 41012 Carpi(Mo)
Tel/Fax: +39 059 640182 - Cel: +39 328 7815571
E-mail: luca.pedrielli@barradev.it
-----------------------------------------------------------------------=
-------=20

Questo messaggio =E8 destinato unicamente alla/e persona/e sopraindicat=
a/e.=20
E' strettamente personale e pu=F2 contenere informazioni la cui riserva=
tezza =E8=20
tutelata dalla normativa sulla "privacy".=20
E' espressamente vietato alla/e persona/e non destinataria/e leggere, c=
opiare=20
o comunque usare questo messaggio o diffonderne il contenuto senza=20
autorizzazione.=20
Chi ha ricevuto per errore questo messaggio =E8 pregato di distruggerlo=
 e di
avvertire per telefono o fax o "e-mail" il mittente.
