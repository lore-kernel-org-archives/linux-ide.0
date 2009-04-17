From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] v3 fix error on drivers/ata/pata_legacy.c
Date: Fri, 17 Apr 2009 11:27:13 +0100
Message-ID: <20090417112713.04ed51d7@lxorguk.ukuu.org.uk>
References: <20090417073259.GA6366@helight>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53663 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756870AbZDQK0O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2009 06:26:14 -0400
In-Reply-To: <20090417073259.GA6366@helight>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhenwen Xu <helight.xu@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Fri, 17 Apr 2009 15:32:59 +0800
Zhenwen Xu <helight.xu@gmail.com> wrote:

> fix those errors:
>=20
> drivers/ata/pata_legacy.c: In function =E2=80=98pdc_data_xfer_vlb=E2=80=
=99:
> drivers/ata/pata_legacy.c:289: error: =E2=80=98ap=E2=80=99 undeclared=
 (first use in this function)
> drivers/ata/pata_legacy.c:289: error: (Each undeclared identifier is =
reported only once
> drivers/ata/pata_legacy.c:289: error: for each function it appears in=
=2E)
> drivers/ata/pata_legacy.c: At top level:
> drivers/ata/pata_legacy.c:869: error: =E2=80=98ATA_PFLAG_PIO32_CHANGE=
=E2=80=99 undeclared here (not in a
> +function)
> make[2]: *** [drivers/ata/pata_legacy.o] Error 1
> make[1]: *** [drivers/ata] Error 2

Looks good to me. I shall have to find something larger than PROPOSED i=
n
the patch title to stop Jeff applying things that were discussion code

Acked-by: Alan Cox <alan@linux.intel.com>
