From: =?UTF-8?B?TWFydGluIFBvdm9sbsO9?= <martin.povolny@solnet.cz>
Subject: Re: Promise TX4200 support?
Date: Tue, 19 Jul 2005 06:36:46 +0200
Message-ID: <42DC835E.7030301@solnet.cz>
References: <42DBFC9E.1040607@gentoo.org> <42DC0A99.2010304@solnet.cz> <42DC2F44.7000708@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.solnet.cz ([193.165.198.50]:19138 "EHLO solnet.cz")
	by vger.kernel.org with ESMTP id S261943AbVGSEhV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jul 2005 00:37:21 -0400
Received: from mail by solnet.cz with scanned-ok (Exim 3.35 #1 (Debian))
	id 1Dujqz-0007xr-00
	for <linux-ide@vger.kernel.org>; Tue, 19 Jul 2005 06:37:13 +0200
In-Reply-To: <42DC2F44.7000708@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Hi Martin,
>=20
> Martin Povoln=C3=BD wrote:
>=20
>> We are succesfully running patched sata_promise with 3 disks in a
>> raid5/raid1 setup. (Patched against ubuntu linux-image 2.6.11-1-686
>> package.)
>=20
>=20
> Could you please either send in your patch, or tell me which board_
> setting (2037x/20319/20619) the device ID table should include so I c=
an
> write submit one myself.
>=20

=46or me it works with 20319, but I don't understand the difference
between different settings.

*** sata_promise.c	2005-05-11 21:22:20.000000000 +0200
--- sata_promise_new.c	2005-05-11 21:22:02.000000000 +0200
***************
*** 164,171 ****
--- 164,173 ----
  	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
  	  board_20319 },
  	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
  	  board_20319 },
+ 	{ PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+ 	  board_20319 },
  	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
  	  board_20319 },

  	{ }	/* terminate list */

Regards,

--=20
Mgr. Martin Povoln=C3=BD, soLNet, s.r.o.,
+420777714458, martin.povolny@solnet.cz

