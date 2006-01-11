From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [CFT 1/3] Add ide_bus_type probe and remove methods
Date: Wed, 11 Jan 2006 16:01:51 +0100
Message-ID: <58cb370e0601110701t1b7859f9i1a13f5a915de6043@mail.gmail.com>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
	 <20060106114059.13.30@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.205]:52903 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932398AbWAKPBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jan 2006 10:01:55 -0500
Received: by nproxy.gmail.com with SMTP id x29so31695nfb
        for <linux-ide@vger.kernel.org>; Wed, 11 Jan 2006 07:01:52 -0800 (PST)
In-Reply-To: <20060106114059.13.30@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg K-H <greg@kroah.com>, IDE <linux-ide@vger.kernel.org>

On 1/6/06, Russell King <rmk@arm.linux.org.uk> wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> (This is an additional patch - on lkml, see
>  "[CFT 1/29] Add bus_type probe, remove, shutdown methods.")

Looks fine but shouldn't it also update drivers/scsi/ide-scsi.c?

With ide-scsi.c updated it is is fine with me:

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> ---
>  drivers/ide/ide-cd.c     |   14 +++++---------
>  drivers/ide/ide-disk.c   |   22 ++++++++--------------
>  drivers/ide/ide-floppy.c |   14 +++++---------
>  drivers/ide/ide-tape.c   |   18 +++++++-----------
>  drivers/ide/ide.c        |   31 +++++++++++++++++++++++++++++++
>  include/linux/ide.h      |    5 +++++
>  6 files changed, 61 insertions(+), 43 deletions(-)
