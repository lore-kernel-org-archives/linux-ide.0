From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.7] new NVIDIA libata SATA driver
Date: Wed, 16 Jun 2004 23:13:57 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40D10C75.80506@pobox.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B1@mail-sc-6-bk.nvidia.com> <200406170312.42324.bzolnier@elka.pw.edu.pl> <20040617012009.GA10879@havoc.gtf.org> <200406170449.37566.markus.kossmann@inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8656 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266230AbUFQDON
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jun 2004 23:14:13 -0400
In-Reply-To: <200406170449.37566.markus.kossmann@inka.de>
List-Id: linux-ide@vger.kernel.org
To: Markus Kossmann <markus.kossmann@inka.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Markus Kossmann wrote:
> Am Donnerstag, 17. Juni 2004 03:20 schrieben Sie:
> [...]
> 
>>Then, I'll apply a patch that adds Kconfig questions
>>
>>	Include hardware that conflicts with libata SATA driver?
>>	(in drivers/ide)
>>and
>>	Include hardware that conflicts with IDE driver?
>>	(in libata, drivers/scsi)
>>
>>and apply the associated ifdefs to the low-level drivers.
>>
> 
> This patch will address the conflict between sata_sil and siimage, too ? 

Yep.

	Jeff



