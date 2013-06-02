From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_rcar: fix interrupt handling
Date: Sun, 02 Jun 2013 15:39:54 +0400
Message-ID: <51AB2F0A.9030703@cogentembedded.com>
References: <201306010238.35442.sergei.shtylyov@cogentembedded.com> <51A92CF0.3090804@cogentembedded.com> <20130602075821.GA8286@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:62150 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab3FBLj6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Jun 2013 07:39:58 -0400
Received: by mail-lb0-f182.google.com with SMTP id q15so695299lbi.27
        for <linux-ide@vger.kernel.org>; Sun, 02 Jun 2013 04:39:57 -0700 (PDT)
In-Reply-To: <20130602075821.GA8286@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

Hello.

On 02-06-2013 11:58, Tejun Heo wrote:

>>> The driver's interrupt handling code is too picky in deciding wheth=
er it should
>>> handle an interrupt or not which causes completely unneeded spuriou=
s interrupts.
>>> Thus make sata_rcar_{ata|serr}_interrupt() *void*; add ATA status r=
egister read
>>> to sata_rcar_ata_interrupt() to clear an unexpected ATA interrupt -=
- it doesn't
>>> get cleared by writing to the SATAINTSTAT register in the interrupt=
 mode we use.

>>> Also, in sata_rcar_ata_interrupt() we should check SATAINTSTAT regi=
ster only for
>>> enabled interrupts and we should clear  only those interrupts  that=
 we have read
>>> as active first time around, because else we have  a  race and risk=
 clearing  an
>>> interrupt that  can  occur between read  and write of the  SATAINTS=
TAT  register
>>> and never registering it...

>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>      Darn, I forgot to Cc: stable@vger.kernel.org again.

> Applied to libata/for-3.10-fixes w/ stable cc'd.  BTW, the driver
> generates the following compile warning.

>     CC      drivers/ata/sata_rcar.o
>     drivers/ata/sata_rcar.c: In function =E2=80=98sata_rcar_thaw=E2=80=
=99:
>     drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly =
truncated to unsigned type [-Woverflow]

     It compiles without warnings for me, IIRC. What version of gcc are=
=20
you using?

> Care to fix it?

    I'll look into it...

> Thanks.

MBR, Sergei

