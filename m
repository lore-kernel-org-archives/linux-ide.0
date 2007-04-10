From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: HPA support
Date: Tue, 10 Apr 2007 19:36:18 -0400
Message-ID: <461C1F72.1070902@pobox.com>
References: <20070411002313.29069ca5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40451 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161105AbXDJXgU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Apr 2007 19:36:20 -0400
In-Reply-To: <20070411002313.29069ca5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Add support for ignoring the BIOS HPA result (off by default) and setting
> the disk to the full available size unless already frozen.
> 
> Tested with various platforms/disks and confirmed to work with the
> Macintosh (which broke earlier) and ata_piix (breakage due to the LBA48
> readback that Tejun fixed).
> 
> For normal users this brings us, I believe, to feature parity with old IDE
> (and of course more featured in some areas too).

Any additional credit for this patch, or was it all you?

	Jeff



