From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sat, 27 Mar 2004 18:11:57 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40660A3D.3020300@pobox.com>
References: <4066021A.20308@pobox.com> <40660877.3090302@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8115 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261925AbUC0XMQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 18:12:16 -0500
In-Reply-To: <40660877.3090302@stesmi.com>
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Stefan Smietanowski wrote:
> What will happen when a PATA disk lies behind a Marvel(ous) bridge, as
> in most SATA disks today?

Larger transfers work fine in PATA, too.

WRT bridges, it is generally the best idea to limit to UDMA/100 (udma), 
but larger transfers are OK.


> Is large transfers mandatory in the LBA48 spec and is LBA48 really
> mandatory in SATA?

Yes and no, in that order :)  SATA doesn't mandate lba48, but it is 
highly unlikely that you will see SATA disk without lba48.

Regardless, libata supports what the drive supports.  Older disks still 
work just fine.

	Jeff



