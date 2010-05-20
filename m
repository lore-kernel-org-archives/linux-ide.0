From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] PXA DMA-capable PATA driver
Date: Thu, 20 May 2010 12:28:42 +0200
Message-ID: <201005201228.42325.marek.vasut@gmail.com>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com> <201005180053.54248.marek.vasut@gmail.com> <4BF4F773.102@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51654 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab0ETKaP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 06:30:15 -0400
Received: by fxm10 with SMTP id 10so3353749fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 03:30:13 -0700 (PDT)
In-Reply-To: <4BF4F773.102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com

Dne =C4=8Ct 20. kv=C4=9Btna 2010 10:48:51 Tejun Heo napsal(a):
> On 05/18/2010 12:53 AM, Marek Vasut wrote:
> > 4766 /**
> > 4767  *      atapi_check_dma - Check whether ATAPI DMA can be suppo=
rted
> > 4768  *      @qc: Metadata associated with taskfile to check
> > 4769  *
> > 4770  *      Allow low-level driver to filter ATA PACKET commands,
> > returning 4771  *      a status indicating whether or not it is OK =
to
> > use DMA for the 4772  *      supplied PACKET command.
> > 4773  *
> > 4774  *      LOCKING:
> > 4775  *      spin_lock_irqsave(host lock)
> > 4776  *
> > 4777  *      RETURNS: 0 when ATAPI DMA can be used
> > 4778  *               nonzero otherwise
> > 4779  */
> >=20
> > this is from libata-core.c FYI and -EOPNOTSUPP is non-zero.
>=20
> Argh... that method needs to be changed to return bool.

That'd make sense.
