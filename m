From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: HPA support
Date: Wed, 11 Apr 2007 01:15:34 +0100
Message-ID: <20070411011534.0aa9d81e@the-village.bc.nu>
References: <20070411002313.29069ca5@the-village.bc.nu>
	<461C1F72.1070902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50364 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933166AbXDKA6x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Apr 2007 20:58:53 -0400
In-Reply-To: <461C1F72.1070902@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Tue, 10 Apr 2007 19:36:18 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Alan Cox wrote:
> > Signed-off-by: Alan Cox <alan@redhat.com>
> > 
> > Add support for ignoring the BIOS HPA result (off by default) and setting
> > the disk to the full available size unless already frozen.
> > 
> > Tested with various platforms/disks and confirmed to work with the
> > Macintosh (which broke earlier) and ata_piix (breakage due to the LBA48
> > readback that Tejun fixed).
> > 
> > For normal users this brings us, I believe, to feature parity with old IDE
> > (and of course more featured in some areas too).
> 
> Any additional credit for this patch, or was it all you?

Good point, where did the other Signoffs go.

Original patch: Kyle McMartin <kyle@canonical.com>
