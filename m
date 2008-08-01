From: =?UTF-8?B?RGF2aWQgTcO8bGxlcg==?= <dave.mueller@gmx.ch>
Subject: Re: [PATCH] libata: Fix a large collection of DMA mode mismatches
Date: Fri, 01 Aug 2008 13:56:56 +0200
Message-ID: <4892FA08.7070403@gmx.ch>
References: <20080801091834.5ca39334@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40108 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752507AbYHAL5Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 07:57:16 -0400
In-Reply-To: <20080801091834.5ca39334@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox wrote:
>  drivers/ata/libata-core.c |    4 ++--
>  drivers/ata/pata_acpi.c   |    2 +-
>  drivers/ata/pata_atiixp.c |    2 +-
>  drivers/ata/pata_cs5530.c |    6 +++---
>  drivers/ata/pata_sc1200.c |    6 +++---
>  include/linux/libata.h    |   22 ++++++++++++++++++++++
>  6 files changed, 32 insertions(+), 10 deletions(-)

A patch for the "pata_oldpiix" driver seems to be missing.

Signed-off-by: Dave Mueller <dave.mueller@gmx.ch>

diff -dpurN a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
--- a/drivers/ata/pata_oldpiix.c    2008-07-14 18:19:53.000000000 +0200
+++ b/drivers/ata/pata_oldpiix.c    2008-08-01 13:17:34.000000000 +0200
@@ -198,7 +198,7 @@ static unsigned int oldpiix_qc_issue(str

  	if (adev != ap->private_data) {
  		oldpiix_set_piomode(ap, adev);
-		if (adev->dma_mode)
+		if (ata_dma_enabled(adev))
  			oldpiix_set_dmamode(ap, adev);
  	}
  	return ata_sff_qc_issue(qc);


