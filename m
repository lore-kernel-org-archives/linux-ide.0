From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sat, 27 Mar 2004 18:40:26 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406610EA.4010607@pobox.com>
References: <4066021A.20308@pobox.com> <40660877.3090302@stesmi.com> <200403280032.22180.bzolnier@elka.pw.edu.pl> <40660FEC.8080703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36788 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261926AbUC0Xkk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 18:40:40 -0500
In-Reply-To: <40660FEC.8080703@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jeff Garzik wrote:
> That's the main limitation on request size right now...  libata limits 
> S/G table entries to 128[1], so a perfectly aligned, fully merged 

    ...

[1] because even though the block layer properly splits on segment 
boundaries, pci_map_sg() may violate those boundaries (James B and 
others are working on fixing this).  So...  for right now the driver 
must check the s/g entry boundaries after DMA mapping, and split them 
(again) if necessary.  IDE does this in ide_build_dmatable().


