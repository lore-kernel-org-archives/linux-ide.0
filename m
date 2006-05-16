From: =?ISO-8859-15?Q?Martin_Ammerm=FCller?=
	<martin.ammermueller@bnro.de>
Subject: [FYI] Update on sata_sil problem with timeouts (was: Re: [sata_sil]Random
 timeout error (data loss))
Date: Tue, 16 May 2006 18:07:39 +0200
Message-ID: <4469F8CB.7040706@bnro.de>
References: <443E6B81.5090004@bnro.de> <443E916F.1040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout02.sul.t-online.com ([194.25.134.17]:17298 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751841AbWEPQIq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 12:08:46 -0400
In-Reply-To: <443E916F.1040203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I tested 2.6.17-rc4-mm1 and 2.6.17-rc4 in the last days and got similar
error messages (command timeout & translated ATA stat/err).

I used 5 simultaneously started instances of bonnie++ for testing.

Best Regards,
Martin Ammerm=FCller

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEafjLituPSWPX2AIRAoutAJsGiYeXbjRHLHoKHwU1OrNFi9ACVgCeOOgE
=46L/vfEQvIDBdRiqlv1nekbc=3D
=3DIo7D
-----END PGP SIGNATURE-----
