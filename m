From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata PATA support - work items?
Date: Tue, 04 Jan 2005 18:32:17 -0500
Message-ID: <41DB2781.7000203@pobox.com>
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52618 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262427AbVADXcg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jan 2005 18:32:36 -0500
In-Reply-To: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> The following PATA work items were previously collected from the mailing list:
>     1. ATAPI
>        1.1 possibly avoid REPORT LUNS for ATAPI devices
>        1.2 when check condition occurs, automatically request sense inside 
>             driver, and put that data into the sense buffer.
>        1.3 make INQUIRY report SCSI version MMC-3 (or later...)
>        1.4 support strange sector sizes
>     2. C/H/S addressing; libata currently hardcoded to use LBA
>     3. add PATA device errata/blacklist info
>    (Any missing items?)
> 
> Need your advice, thanks.

Yes, this seems like an accurate list to me.

I would probably prioritize #3 as the most important, followed by C/H/S
support.

	Jeff


