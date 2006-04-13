From: =?ISO-8859-15?Q?Martin_Ammerm=FCller?=
	<martin.ammermueller@bnro.de>
Subject: Re: [sata_sil]Random timeout error (data loss)
Date: Thu, 13 Apr 2006 19:56:46 +0200
Message-ID: <443E90DE.1080705@bnro.de>
References: <443E6B81.5090004@bnro.de> <443E916F.1040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout11.sul.t-online.com ([194.25.134.85]:43185 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964957AbWDMT76 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Apr 2006 15:59:58 -0400
In-Reply-To: <443E916F.1040203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tejun Heo schrieb:
> Please post the result of 'lspci -n'

What i forgot to mention: after the error no data can be written or rea=
d
to disk anymore (only solution is a hard reset). This applies AFAICS to
2.6.17-rc1 (testet a few minutes ago) with a slightly different error
message, too:

ata1: command 0xca timeout, stat 0x50 host_stat 0x24

Output of lspci -n :

0000:00:00.0 0600: 1002:5a31 (rev 01)
0000:00:01.0 0604: 1002:5a3f
0000:00:12.0 0101: 1002:4379 (rev 80)
0000:00:13.0 0c03: 1002:4374 (rev 80)
0000:00:13.1 0c03: 1002:4375 (rev 80)
0000:00:13.2 0c03: 1002:4373 (rev 80)
0000:00:14.0 0c05: 1002:4372 (rev 81)
0000:00:14.1 0101: 1002:4376 (rev 80)
0000:00:14.2 0403: 1002:437b (rev 01)
0000:00:14.3 0601: 1002:4377 (rev 80)
0000:00:14.4 0604: 1002:4371 (rev 80)
0000:01:05.0 0300: 1002:5a62
0000:02:04.0 0200: 168c:001a (rev 01)
0000:02:06.0 0607: 1524:1410 (rev 01)
0000:02:07.0 0200: 10ec:8139 (rev 10)
0000:02:0a.0 0c00: 104c:8026

The system is a Toshiba Satellite A100-512

Regards,
Martin Ammerm=FCller
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPpDeituPSWPX2AIRAhwmAJoDQi921osUsFS4KRzsvwrkfYyhZACfdoV4
8yW3giN4VUhOiftgdQ+GU84=3D
=3Dg4zF
-----END PGP SIGNATURE-----
