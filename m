From: Markus Kossmann <markus.kossmann@inka.de>
Subject: Re: [PATCH 2.6.7] new NVIDIA libata SATA driver
Date: Thu, 17 Jun 2004 04:49:35 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406170449.37566.markus.kossmann@inka.de>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B1@mail-sc-6-bk.nvidia.com> <200406170312.42324.bzolnier@elka.pw.edu.pl> <20040617012009.GA10879@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:7161 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264660AbUFQCuV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jun 2004 22:50:21 -0400
In-Reply-To: <20040617012009.GA10879@havoc.gtf.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Am Donnerstag, 17. Juni 2004 03:20 schrieben Sie:
[...]
> Then, I'll apply a patch that adds Kconfig questions
>
> 	Include hardware that conflicts with libata SATA driver?
> 	(in drivers/ide)
> and
> 	Include hardware that conflicts with IDE driver?
> 	(in libata, drivers/scsi)
>
> and apply the associated ifdefs to the low-level drivers.
>
This patch will address the conflict between sata_sil and siimage, too ? 
