From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 17:37:13 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403281737.13972.bzolnier@elka.pw.edu.pl>
References: <4066021A.20308@pobox.com> <40660A3D.3020300@pobox.com> <40667D8D.2030802@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14749 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261611AbUC1P2I
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 10:28:08 -0500
In-Reply-To: <40667D8D.2030802@stesmi.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Sunday 28 of March 2004 09:23, Stefan Smietanowski wrote:
> Hi Jeff.
>
> >> What will happen when a PATA disk lies behind a Marvel(ous) bridge, as
> >> in most SATA disks today?
> >
> > Larger transfers work fine in PATA, too.
>
> Correct me if I'm wrong but wasn't the max number of sectors in a
> transfer limited to 255 instead of 256 because there were buggy
> drives out there before ? I seem to recall something like that but
> I could be wrong.

There was 255 sectors limit in IDE driver but it was based only on _one_
bugreport on _unreliable_ drive (256 sectors causes heavier I/O load).

AFAIR "the other OS" is using 256 sectors so this value is safe.

Regards,
Bartlomiej

