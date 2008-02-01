From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH #upstream] libata: implement libata.force module parameter
Date: Fri, 1 Feb 2008 18:46:32 +0100
Message-ID: <58cb370e0802010946v3544a4echc08a17f678222555@mail.gmail.com>
References: <47A3375F.80101@gmail.com> <47A356C3.3010904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:45896 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbYBARqd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 12:46:33 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1163039fkz.5
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 09:46:32 -0800 (PST)
In-Reply-To: <47A356C3.3010904@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Feb 1, 2008 6:28 PM, Jeff Garzik <jeff@garzik.org> wrote:
> Tejun Heo wrote:
> > This patch implements libata.force module parameter which can
> > selectively override ATA port, link and device configurations
> > including cable type, SATA PHY SPD limit, transfer mode and NCQ.
> >
> > For example, you can say "use 1.5Gbps for all fan-out ports attached
> > to the second port but allow 3.0Gbps for the PMP device itself, oh,
> > the device attached to the third fan-out port chokes on NCQ and
> > shouldn't go over UDMA4" by the following.
> >
> >  libata.force=2:1.5g,2.15:3.0g,2.03:noncq,udma4
> >
> > Signed-off-by: Tejun Heo <htejun@gmail.com>
> > ---
> > I guess it's about time we add something like this.  More than
> > anything else this should help debugging and can serve as a last
> > resort to work around problems.
> >
> > Thanks.
> >
> >  Documentation/kernel-parameters.txt |   35 +++
> >  drivers/ata/libata-core.c           |  375 +++++++++++++++++++++++++++++++++++-
> >  drivers/ata/libata-eh.c             |    8
> >  drivers/ata/libata.h                |    1
> >  4 files changed, 415 insertions(+), 4 deletions(-)
>
> ACK, but it breaks the build due to section type conflicts:
>
> drivers/ata/libata-core.c:108: error: ata_force_param_buf causes a
> section type conflict
>
> Given that the data is marked __initdata and the code is marked __init,
> I cannot see the problem.

the data is marked as "const"
