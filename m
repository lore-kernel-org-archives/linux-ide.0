From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
Date: Thu, 05 Aug 2004 19:13:34 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4112BF1E.9070404@pobox.com>
References: <41126458.1050203@emc.com> <1091724300.8043.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19375 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267752AbUHEXN4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Aug 2004 19:13:56 -0400
In-Reply-To: <1091724300.8043.58.camel@localhost.localdomain>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brett Russ <russb@emc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Alan Cox wrote:
> Once Jeff has MWDMA and ATAPI in the new SATA/ATA driver he wrote then
> migration might be an even better option. It'll certainly be easier to
> do a lot of things right with the newest SATA code than with the current
> IDE layer.


BTW MWDMA is already done and checked in :)

