From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/4] CHS: support overriding the ata_rwcmd_protocol()
 function (resend)
Date: Wed, 05 Oct 2005 20:03:20 +0800
Message-ID: <4343C108.2000502@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com> <434276B9.7080807@tw.ibm.com> <43427AFD.1020405@pobox.com> <4343B5F5.4090402@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63185 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965131AbVJEMD3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 08:03:29 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j95C3TXn014391
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2005 08:03:29 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j95C3T08102084
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2005 08:03:29 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j95C3S1N026015
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2005 08:03:28 -0400
In-Reply-To: <4343B5F5.4090402@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

(Resend for the tab problem)
Patch 3/4:
   support overriding the ata_rwcmd_protocol() function for some VIA
adapters per Alan's advice.

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

=======

--- ch2/include/linux/libata.h	2005-10-05 18:11:12.000000000 +0800
+++ ch3/include/linux/libata.h	2005-10-05 18:11:51.000000000 +0800
@@ -353,6 +353,8 @@ struct ata_port_operations {
  	void (*phy_reset) (struct ata_port *ap);
  	void (*post_set_mode) (struct ata_port *ap);

+	/* workaround host adapter limitations */
+	void (*rwcmd_protocol) (struct ata_queued_cmd *qc);
  	int (*check_atapi_dma) (struct ata_queued_cmd *qc);

  	void (*bmdma_setup) (struct ata_queued_cmd *qc);
--- ch2/drivers/scsi/libata-core.c	2005-10-05 18:11:12.000000000 +0800
+++ ch3/drivers/scsi/libata-core.c	2005-10-05 18:11:51.000000000 +0800
@@ -677,7 +677,14 @@ static void ata_qc_rwcmd_protocol(struct
   */
  void ata_rwcmd_protocol(struct ata_queued_cmd *qc)
  {
-	ata_qc_rwcmd_protocol(qc);
+	/* give LLD a chance to override
+	 * ex. for some VIA adapters, LLD have to use
+	 *     PIO commands if LBA48 + DMA is seen.
+	 */
+	if (qc->ap->ops->rwcmd_protocol)
+		qc->ap->ops->rwcmd_protocol(qc);
+	else
+		ata_qc_rwcmd_protocol(qc);
  }

  static const char * xfer_mode_str[] = {


