From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] libata atapi work #2
Date: Fri, 14 May 2004 14:44:21 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405141444.21700.bzolnier@elka.pw.edu.pl>
References: <40A42218.5040905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11746 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265172AbUENMn7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 08:43:59 -0400
In-Reply-To: <40A42218.5040905@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Pat LaVarre <p.lavarre@ieee.org>


Jeff, is this intentional?

@@ -2457,6 +2457,13 @@
 		queue_work(ata_wq, &ap->pio_task);
 		break;
 
+	case ATA_PROT_ATAPI:
+	case ATA_PROT_ATAPI_DMA:
+		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+		queue_work(ata_wq, &ap->packet_task);
+		break;
+
 	default:
 		WARN_ON(1);
 		return -1;

