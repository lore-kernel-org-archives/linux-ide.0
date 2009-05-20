From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Wed, 20 May 2009 18:50:40 +0000
Message-ID: <1242845440.2881.74.camel@localhost.localdomain>
References: <20090520065942.GD11363@kernel.dk>
	 <20090520070038.GE11363@kernel.dk>
	 <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com>
	 <e7510f760905201108l4486ff6foc560c1271ebee7a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51493 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757207AbZETSuh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 14:50:37 -0400
In-Reply-To: <e7510f760905201108l4486ff6foc560c1271ebee7a7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Grant Grundler <grundler@google.com>, Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, jeff@garzik.org, htejun@gmail.com

On Wed, 2009-05-20 at 11:08 -0700, Gwendal Grignou wrote:
> Form the ATA and SATA spec, NCQ is per device. It is possible to
> assign the same tag on different port, the disks and PMP will not
> care.
> However, today, we assign tag on a port basis [see
> __ata_qc_from_tag()], therefore only 32 commands can be inflight to
> all devices behind a given port.
> 
> Being able to a do a mapping qc <---> {pmp port, tag} instead of just
> qc <---> {tag} will provide a performance boost when disks supporting
> NCQ are connected behind a PMP. Maybe it can be done, by moving qcmd
> from ata_port to ata_link.
> 
> As Tejun said, the patch needs more work to be able to support same
> tag used on 2 different links behind the same port.
> Also, given we are changing the amount of commands we sent to the
> controller, we would have to change can_queue from ATA_MAX_QUEUE to
> ATA_MAX_QUEUE*n, where n is the number of ports supported by the
> controller [max SATA_PMP_MAX_PORTS, but some controller, like SiI3132
> only supports 5 devices, and other may only support n = 1]
> 
> When done, the patch will require a great amount of testing, given we
> will exercise the controllers in a brand new way. A white list might
> be necessary.
> 
> Jens, using SCSI tagging for ata commands is a great idea, but it is
> no small feat...

So realistically, you want one block queue per PMP port rather than an
artificial limits adjustment on the single queue per output phy ... this
shouldn't be too hard: it is exactly the way the SAS transport class
(and libsas) works today for expander connected SAS devices.

James


