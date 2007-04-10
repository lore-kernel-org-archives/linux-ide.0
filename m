From: Kyle McMartin <kyle@canonical.com>
Subject: Re: [PATCH] libata: HPA support
Date: Tue, 10 Apr 2007 19:43:11 -0400
Message-ID: <20070410234311.GA8517@athena.road.mcmartin.ca>
References: <20070411002313.29069ca5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:36841 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161114AbXDJXom (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Apr 2007 19:44:42 -0400
Content-Disposition: inline
In-Reply-To: <20070411002313.29069ca5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, Apr 11, 2007 at 12:23:13AM +0100, Alan Cox wrote:
> Add support for ignoring the BIOS HPA result (off by default) and setting
> the disk to the full available size unless already frozen.
> 
> Tested with various platforms/disks and confirmed to work with the
> Macintosh (which broke earlier) and ata_piix (breakage due to the LBA48
> readback that Tejun fixed).
> 
> For normal users this brings us, I believe, to feature parity with old IDE
> (and of course more featured in some areas too).
> 

Awesome! Thanks for sheparding this.

Acked-by: Kyle McMartin <kyle@canonical.com>

Cheers,
	Kyle
