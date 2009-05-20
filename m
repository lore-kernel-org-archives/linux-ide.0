From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Wed, 20 May 2009 14:51:37 -0400
Message-ID: <4A145139.8000007@garzik.org>
References: <20090520065942.GD11363@kernel.dk>	 <20090520070038.GE11363@kernel.dk>	 <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com> <e7510f760905201108l4486ff6foc560c1271ebee7a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39965 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbZETSvm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 14:51:42 -0400
In-Reply-To: <e7510f760905201108l4486ff6foc560c1271ebee7a7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Grant Grundler <grundler@google.com>, Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, htejun@gmail.com

Gwendal Grignou wrote:
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

Well, I think a few things are getting confused, here.

Assigning 32 tags to each port is the best we can do, given existing 
hardware, which provides command slots on a per-port basis.

can_queue is a largely a host-wide limit that does not really apply to 
modern SATA, because we (and Jens patch) set queue depth properly. 
can_queue is mainly used these days for master/slave arbitration, and we 
mainly need to ensure that can_queue does not add additional, unneeded 
limits on top of the more fine-grained limits being configured.

	Jeff




