From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.9-libata1-dev1] libata-scsi: hdparm support
Date: Sat, 23 Oct 2004 14:36:59 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04102305363da96ebd@mail.gmail.com>
References: <1098487253.28916.12.camel@server.lorenz.priv>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.203]:26307 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261155AbUJWMhC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Oct 2004 08:37:02 -0400
Received: by rproxy.gmail.com with SMTP id 77so290815rnk
        for <linux-ide@vger.kernel.org>; Sat, 23 Oct 2004 05:36:59 -0700 (PDT)
In-Reply-To: <1098487253.28916.12.camel@server.lorenz.priv>
List-Id: linux-ide@vger.kernel.org
To: Tobias Lorenz <tobias.lorenz@gmx.net>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hi,

On Sat, 23 Oct 2004 01:20:53 +0200, Tobias Lorenz <tobias.lorenz@gmx.net> wrote:
> Hi,
> 
> this patch adds support for transfering drive informations via the
> hd_driveid structure to the hdparm utility. At the moment, only
> cylinders, sectors, heads, model and firmware version are transfered.
> 
> Our intention was to display the supported and the used UDMA mode(s),
> but we didn't find the correct structures yet to get these infos...

dev->id

HDIO_GET_IDENTITY (as used by 'hdparm -i') should return _original_
drive ID (dev->id should be returned) so currently used mode may not
be reported correctly.

'hdparm -I' should be already supported by current libata-dev tree.

Bartlomiej
