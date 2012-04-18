From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Wed, 18 Apr 2012 15:34:09 -0400
Message-ID: <CA+5PVA7zv2H-CQU3Grouk3KH5xA3XLijuO7TPX9zrMdj-7z43Q@mail.gmail.com>
References: <20120418184624.GA16313@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:33766 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156Ab2DRTeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 15:34:10 -0400
In-Reply-To: <20120418184624.GA16313@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Apr 18, 2012 at 2:46 PM, Jeff Garzik <jeff@garzik.org> wrote:
>
> NOTE: Includes important regression fix. =A0See signed tag message fo=
r more.
>
> Please pull 0c8d32c27f5cf6e14ca14b4758d1e994eebd50fd from
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git =
tag/upstream-linus
>
>
> to receive the following updates:
>
> =A0drivers/ata/ata_piix.c =A0 =A0 =A0 =A0 | =A0 =A02 ++
> =A0drivers/ata/libata-core.c =A0 =A0 =A0| =A0 =A04 ++--
> =A0drivers/ata/libata-scsi.c =A0 =A0 =A0| =A0 =A04 ++--
> =A0drivers/ata/libata-transport.c | =A0 =A01 +
> =A0drivers/ata/libata.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/ata/sata_mv.c =A0 =A0 =A0 =A0 =A0| =A0 =A03 ++-
> =A06 files changed, 10 insertions(+), 6 deletions(-)
>
> Dan Carpenter (1):
> =A0 =A0 =A0sata_mv: silence an uninitialized variable warning
>
> Dan Williams (1):
> =A0 =A0 =A0libata: make ata_print_id atomic
>
> Lin Ming (1):
> =A0 =A0 =A0libata: forbid port runtime pm by default, fixing regressi=
on

I noticed that this regression fix doesn't have the
CC: stable@vger.kernel.org tag in it, but it's needed on the 3.3
trees.  Should it be sent to the stable list separately?

josh
