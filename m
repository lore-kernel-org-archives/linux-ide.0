From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] v3 fix error on drivers/ata/pata_legacy.c
Date: Fri, 17 Apr 2009 06:41:45 -0400
Message-ID: <49E85CE9.4090306@pobox.com>
References: <20090417073259.GA6366@helight> <20090417112713.04ed51d7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51180 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760724AbZDQKlv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 06:41:51 -0400
In-Reply-To: <20090417112713.04ed51d7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zhenwen Xu <helight.xu@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Fri, 17 Apr 2009 15:32:59 +0800
> Zhenwen Xu <helight.xu@gmail.com> wrote:
>=20
>> fix those errors:
>>
>> drivers/ata/pata_legacy.c: In function =E2=80=98pdc_data_xfer_vlb=E2=
=80=99:
>> drivers/ata/pata_legacy.c:289: error: =E2=80=98ap=E2=80=99 undeclare=
d (first use in this function)
>> drivers/ata/pata_legacy.c:289: error: (Each undeclared identifier is=
 reported only once
>> drivers/ata/pata_legacy.c:289: error: for each function it appears i=
n.)
>> drivers/ata/pata_legacy.c: At top level:
>> drivers/ata/pata_legacy.c:869: error: =E2=80=98ATA_PFLAG_PIO32_CHANG=
E=E2=80=99 undeclared here (not in a
>> +function)
>> make[2]: *** [drivers/ata/pata_legacy.o] Error 1
>> make[1]: *** [drivers/ata] Error 2
>=20
> Looks good to me. I shall have to find something larger than PROPOSED=
 in
> the patch title to stop Jeff applying things that were discussion cod=
e

It had a 'signed-off-by', which I took to mean, it was a proposed patch=
=20
that was OK to merge once people were happy...  Sorry about that=20
misinterpretation.

	Jeff




