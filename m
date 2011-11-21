From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata SFF and BDBMA
Date: Sun, 20 Nov 2011 20:16:51 -0500
Message-ID: <4EC9A683.5000005@garzik.org>
References: <20111120140751.GA21394@x1.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34523 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910Ab1KUBQz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Nov 2011 20:16:55 -0500
Received: by vbbfc21 with SMTP id fc21so2000197vbb.19
        for <linux-ide@vger.kernel.org>; Sun, 20 Nov 2011 17:16:54 -0800 (PST)
In-Reply-To: <20111120140751.GA21394@x1.osrc.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 11/20/2011 09:07 AM, Borislav Petkov wrote:
> Hi,
>
> I managed to cause the following build breakage on current -linus wit=
h
> the attached config:
>
> drivers/ata/libata-sff.c: In function =E2=80=98ata_pci_init_one=E2=80=
=99:
> drivers/ata/libata-sff.c:2538:3: error: implicit declaration of funct=
ion =E2=80=98ata_pci_bmdma_prepare_host=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
> drivers/ata/libata-sff.c:2549:40: error: =E2=80=98ata_bmdma_interrupt=
=E2=80=99 undeclared (first use in this function)
> drivers/ata/libata-sff.c:2549:40: note: each undeclared identifier is=
 reported only once for each function it appears in
> cc1: some warnings being treated as errors
>
> make[2]: *** [drivers/ata/libata-sff.o] Error 1
> make[1]: *** [drivers/ata] Error 2
> make: *** [drivers] Error 2
> make: *** Waiting for unfinished jobs....
>
> due to the fact that CONFIG_ATA_BMDMA is not set. From where I'm
> standing this needs either stubs for the missing functions in the
> include/linux/libata.h header for the case where CONFIG_ATA_BMDMA is =
not
> set, or make CONFIG_ATA_SFF depend on CONFIG_ATA_BMDMA or select it o=
r
> whatever makes most sense.

The fix has been in libata-dev (and thus linux-next) for a couple days,=
=20
and will go to Linus tonight or tomorrow.

	Jeff




