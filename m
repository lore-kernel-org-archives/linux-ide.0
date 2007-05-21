From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Handle SATA bridges better
Date: Mon, 21 May 2007 15:47:41 +0100
Message-ID: <20070521154741.490bcdb6@the-village.bc.nu>
References: <20070521151332.4ec9ea1d@the-village.bc.nu>
	<4651AB20.7070103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47209 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754956AbXEUOoD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 10:44:03 -0400
In-Reply-To: <4651AB20.7070103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

> I'm not sure this is correct.  The SATA bridge can be at the far side of
> PATA cable near to the drive.  ie.
> 
> PATA host <========= PATA cable ==========> P/SATA bridge : SATA drive

Yes

> In this case, most of the cable is PATA and cable detection matters.

The cable detection is done by the drive not the bridge, and for the
boards I've got access to this means that the cable detection doesn't work
at all. This is a big problem with things like the VIA C7 embedded boards
which currently run at the wrong speeds as a result.

> Another problem is that there are still codes which interpret ap->cbl ==
> ATA_CBL_SATA as SATA host port.  They need to be fixed first before
> using ap->cbl for the actual cable type.

I thought we had those all sorted now. A grep shows there is nobody doing
conditional checking off the ap->cbl cable in drivers/ata any more. They
did in the past - which is this patch got held up - but no longer that I
can see.

Alan
