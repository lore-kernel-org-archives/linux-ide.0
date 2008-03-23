From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: assume no device is attached if
 both IDENTIFYs are aborted
Date: Sun, 23 Mar 2008 12:46:09 +0000
Message-ID: <20080323124609.6e3b04cc@core>
References: <47E5F5D5.6050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34084 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761948AbYCWNCK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 09:02:10 -0400
In-Reply-To: <47E5F5D5.6050203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, jb.faq@gmx.de, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sun, 23 Mar 2008 15:16:53 +0900
Tejun Heo <htejun@gmail.com> wrote:

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
> This problem was reported by Jan B=C3=BCcken.
>=20
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Jan B=C3=BCcken <jb.faq@gmx.de>
> ---
> Alan, does this look okay?

Acked-by: Alan Cox <alan@redhat.com>
