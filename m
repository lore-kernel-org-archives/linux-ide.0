From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: assume no device is attached
 if both IDENTIFYs are aborted
Date: Mon, 24 Mar 2008 22:26:13 -0400
Message-ID: <47E862C5.2000008@garzik.org>
References: <47E5F5D5.6050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49172 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064AbYCYC0Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Mar 2008 22:26:16 -0400
In-Reply-To: <47E5F5D5.6050203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jb.faq@gmx.de, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> This is to fix bugzilla #10254.  QSI cdrom attached to pata_sis as
> secondary master appears as phantom device for the slave.
> Interestingly, instead of not setting DRQ after IDENTIFY which
> triggers NODEV_HINT, it aborts both IDENTIFY and IDENTIFY PACKET whic=
h
> makes EH retry.
>=20
> Modify EH such that it assumes no device is attached if both flavors
> of IDENTIFY are aborted by the device.  There really isn't much point
> in retrying when the device actively aborts the commands.
>=20
> While at it, convert NODEV detection message to ata_dev_printk() to
> help debugging obscure detection problems.
>=20
> This problem was reported by Jan B=FCcken.
>=20
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Jan B=FCcken <jb.faq@gmx.de>
> ---
> Alan, does this look okay?
>=20
> Thanks.
>=20
>  drivers/ata/libata-core.c |   38 ++++++++++++++++++++++++-----------=
---
>  1 file changed, 24 insertions(+), 14 deletions(-)

applied

