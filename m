From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.9-libata1-dev1] libata-scsi: hdparm support
Date: Tue, 2 Nov 2004 22:51:36 +0100
Message-ID: <58cb370e041102135138f50dac@mail.gmail.com>
References: <1098487253.28916.12.camel@server.lorenz.priv>
	 <41838C6E.6050702@pobox.com>
	 <1099148337.15964.4.camel@server.lorenz.priv>
	 <4183B2C6.7090500@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.197]:62264 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261978AbUKBVvr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2004 16:51:47 -0500
Received: by rproxy.gmail.com with SMTP id i8so11469rne
        for <linux-ide@vger.kernel.org>; Tue, 02 Nov 2004 13:51:36 -0800 (PST)
In-Reply-To: <4183B2C6.7090500@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tobias Lorenz <tobias.lorenz@gmx.net>, linux-ide@vger.kernel.org

On Sat, 30 Oct 2004 11:27:02 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> Tobias Lorenz wrote:
> > Hi,
> >
> >
> >>This patch doesn't apply, since it is prefixed with "> " ...
> >
> > You are right... here is a corrected version.
> >
> > This patch adds support for transfering drive informations via the
> > hd_driveid structure to the hdparm utility. At the moment, only
> > cylinders, sectors, heads, model and firmware version are transfered.
> 
> Applied to libata-dev...  I'll need to ponder the correctness a bit
> more, before pushing upstream.

Speaking about correctness...

HDIO_GET_IDENTIFY returns ID block in CPU order (not LE).

If you decide to add it sooner or later you will need something ala
ide_fix_driveid() from ide-iops.c (bloat).

Bartlomiej
