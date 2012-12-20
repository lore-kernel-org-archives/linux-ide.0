From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] libata: Shut up annoying native_sectors warning
Date: Thu, 20 Dec 2012 16:04:23 +0100
Message-ID: <20121220150423.GC26635@liondog.tnic>
References: <1356006355-6819-1-git-send-email-bp@alien8.de>
 <20121220130159.7125e700@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:39804 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab2LTPE0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Dec 2012 10:04:26 -0500
Content-Disposition: inline
In-Reply-To: <20121220130159.7125e700@pyramind.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Thu, Dec 20, 2012 at 01:01:59PM +0000, Alan Cox wrote:
> Net lose IMHO - better to file a gcc bug report

Ok, I'll try that. Want on CC?

The good thing is, it is a new issue in 4.7 since it doesn't trigger
with 4.6:

$  make CC=3Dgcc-4.6 drivers/ata/libata-core.o
make[1]: Nothing to be done for `all'.
make[1]: Nothing to be done for `relocs'.
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CC      drivers/ata/libata-core.o

vs

$  make CC=3Dgcc-4.7 drivers/ata/libata-core.o
make[1]: Nothing to be done for `all'.
make[1]: Nothing to be done for `relocs'.
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/x86/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CC      scripts/mod/empty.o
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      drivers/ata/libata-core.o
drivers/ata/libata-core.c: In function =E2=80=98ata_hpa_resize=E2=80=99=
:
drivers/ata/libata-core.c:1397:3: warning: =E2=80=98native_sectors=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
