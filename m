From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [FYI] Update on sata_sil problem with timeouts
Date: Fri, 26 May 2006 20:22:52 -0400
Message-ID: <44779BDC.60900@pobox.com>
References: <443E6B81.5090004@bnro.de> <443E916F.1040203@gmail.com> <4469F8CB.7040706@bnro.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:23265 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751745AbWE0AW5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 20:22:57 -0400
In-Reply-To: <4469F8CB.7040706@bnro.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-15?Q?Martin_Ammerm=FCller?= <martin.ammermueller@bnro.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Martin Ammerm=FCller wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> I tested 2.6.17-rc4-mm1 and 2.6.17-rc4 in the last days and got simil=
ar
> error messages (command timeout & translated ATA stat/err).
>=20
> I used 5 simultaneously started instances of bonnie++ for testing.

Can you retest with the current -mm?

	Jeff



