From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata todo item: retry certain classes of errors
Date: Fri, 07 Jan 2005 14:49:41 +0000
Message-ID: <1105106379.17166.325.camel@localhost.localdomain>
References: <41DE1118.9020209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:20673 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261473AbVAGPzB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Jan 2005 10:55:01 -0500
In-Reply-To: <41DE1118.9020209@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Albert Lee <albertcc@tw.ibm.com>, Andy Warner <andyw@pobox.com>

On Gwe, 2005-01-07 at 04:33, Jeff Garzik wrote:
> libata error handling is still of the "stupid simple" variety.  While 
> that makes it easy to verify, it also means that we don't always recover 
>   from some situations.
> 
> Right now, libata simply returns an error back to the SCSI layer.

I did actually arrange that all the SCSI errors it faked caused the
right retry behaviour at the SCSI level when I did that. Perhaps I
should have commented that fact.

> For DMA, PCI and SATA bus errors, we need to reset the hardware and 
> retry the command.

And for PATA at least possibly also change mode and restore settings.

Alan

