From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 06/27] libata: kill ata_chk_status()
Date: Fri, 04 Apr 2008 03:29:26 -0400
Message-ID: <47F5D8D6.4000901@garzik.org>
References: <1206451025926-git-send-email-htejun@gmail.com> <12064510261000-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60310 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbYDDH3b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:29:31 -0400
In-Reply-To: <12064510261000-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com

Tejun Heo wrote:
> ata_chk_status() just calls ops->check_status and it only adds
> confusion with other status functions.  Kill it.
>=20
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-sff.c    |   22 +++++++++++-----------
>  drivers/ata/pata_bf54x.c    |    2 +-
>  drivers/ata/pata_scc.c      |    2 +-
>  drivers/ata/sata_inic162x.c |   10 +++++-----
>  drivers/ata/sata_sil.c      |    6 +++---
>  drivers/ata/sata_via.c      |    2 +-
>  drivers/ata/sata_vsc.c      |    2 +-
>  include/linux/libata.h      |    7 +------
>  8 files changed, 24 insertions(+), 29 deletions(-)

ACK patches 1-27

applied patches 1-6

patch #7 killed the build at that point:


drivers/ata/pdc_adma.c:154: error: =91ata_std_dev_select=92 undeclared =
here=20
(not in a function)
drivers/ata/pdc_adma.c:155: error: =91ata_tf_load=92 undeclared here (n=
ot in=20
a function)
drivers/ata/pdc_adma.c:156: error: =91ata_tf_read=92 undeclared here (n=
ot in=20
a function)
drivers/ata/pdc_adma.c:157: error: =91ata_check_status=92 undeclared he=
re=20
(not in a function)
drivers/ata/pdc_adma.c:158: error: =91ata_exec_command=92 undeclared he=
re=20
(not in a function)
drivers/ata/pdc_adma.c:159: error: =91ata_data_xfer=92 undeclared here =
(not=20
in a function)
drivers/ata/pdc_adma.c:165: error: =91ata_irq_on=92 undeclared here (no=
t in=20
a function)
drivers/ata/pdc_adma.c:170: error: =91ata_std_softreset=92 undeclared h=
ere=20
(not in a function)
make[2]: *** [drivers/ata/pdc_adma.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/ata] Error 2
make: *** [drivers] Error 2

