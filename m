From: Tejun Heo <htejun@gmail.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Thu, 01 Dec 2005 22:29:09 +0900
Message-ID: <438EFAA5.3070901@gmail.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org> <438EF3B6.7020007@keytradebank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:60504 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932213AbVLAN3O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 08:29:14 -0500
Received: by zproxy.gmail.com with SMTP id 13so60895nzn
        for <linux-ide@vger.kernel.org>; Thu, 01 Dec 2005 05:29:14 -0800 (PST)
In-Reply-To: <438EF3B6.7020007@keytradebank.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>
Cc: Keith Mannthey <kmannth@gmail.com>, "0602@eq.cz" <0602@eq.cz>, Linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Jean-Fran=E7ois Stenuit wrote:
> Hi Tejun,
>=20
> Thanks for taking the time to check.
>=20
> Output of your trace with ata_piix.override_PCS=3D0
>  1st boot : success : combined=3D0 orig_mask=3D0x11
>  2nd boot : success : combined=3D0 orig_mask=3D0x11
>  3rd boot : failure : combined=3D0 orig_mask=3D0x0
>  4th boot : failure : combined=3D0 orig_mask=3D0x0
>  5th boot : failure : combined=3D0 orig_mask=3D0x0
>  6th boot : failure : combined=3D0 orig_mask=3D0x0
>  7th boot : success : combined=3D0 orig_mask=3D0x11
> Output of your trace with ata_piix.override_PCS=3D1
>  1st boot : success : combined=3D0 orig_mask=3D0x0
>  2nd boot : success : combined=3D0 orig_mask=3D0x0
>  3rd boot : success : combined=3D0 orig_mask=3D0x0
>  4th boot : success : combined=3D0 orig_mask=3D0x0
>  5th boot : success : combined=3D0 orig_mask=3D0x0
>  6th boot : success : combined=3D0 orig_mask=3D0x0
>  7th boot : success : combined=3D0 orig_mask=3D0x0
>  8th boot : success : combined=3D0 orig_mask=3D0x0
>=20
> Looks like you have found a fix/workaround for this bug (but it still=
=20
> does not give the reason why it's failing).
>=20

It probably is a BIOS issue.  The weird thing though is that the port=20
works fine with its corresponding ENABLED bit cleared.  Anyways, if it=20
works by ignoring the ENABLED bit, ignoring should just be fine.

0602, can you verify this workaround works on your machine too?

Jeff (Hi!), if 0602 also confirms that this workaround works, I'll=20
submit a patch to make ata_piix ignore PCS values on ICH5's.  How does=20
that sound to you?

--=20
tejun
