From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: ignore all zero PCS value on ICH5's
Date: Mon, 05 Dec 2005 19:17:43 +0900
Message-ID: <439413C7.40701@gmail.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org> <438EF3B6.7020007@keytradebank.com> <438EFAA5.3070901@gmail.com> <438FA924.1090005@pobox.com> <438FB8B5.8070505@gmail.com> <20051202032605.GA15528@htj.dyndns.org> <4394115D.2020603@keytradebank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:15800 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932280AbVLEKRt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2005 05:17:49 -0500
Received: by zproxy.gmail.com with SMTP id 13so759885nzn
        for <linux-ide@vger.kernel.org>; Mon, 05 Dec 2005 02:17:48 -0800 (PST)
In-Reply-To: <4394115D.2020603@keytradebank.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Keith Mannthey <kmannth@gmail.com>, "0602@eq.cz" <0602@eq.cz>, Linux-ide <linux-ide@vger.kernel.org>

Jean-Fran=E7ois Stenuit wrote:
> Hi Tejun,
>=20
> Back to work this morning. I applied this patch to 2.6.15-rc5 to test=
 my=20
> problematic HP DL140G2.
>=20
> Result of the tests :
> Reboot 1 : successfull, patch code used
> Reboot 2 : successfull, patch code not used
> Reboot 3 : successfull, patch code used
> Reboot 4 : successfull, patch code not used
> Reboot 5 : successfull, patch code used
> Cold boot 1 : successfull, patch code used
> Cold boot 2 : successfull, patch code not used
> Cold boot 3 : successfull, patch code not used
> Cold boot 4 : successfull, patch code used
> Cold boot 5 : successfull, patch code used
>=20
> Seems the patch is working.
>=20
> Tejun Heo wrote:
>=20
>> Some ICH5's report 0 for PCS even when they have active working port=
s.
>> This patch makes piix_sata_probe() ignore 0 PCS value on ICH5's and
>> probe all ports in such cases.  And while at it, remove bogus
>> assignment to mask.
>>

Thanks, Jean-Fran=E7ois.  Thanks, 0602.

Jeff, the patch seems to work.  Can you ack or nack it?

--=20
tejun
