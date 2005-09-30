From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/4] libata: irq driven pio follow-up patches
Date: Fri, 30 Sep 2005 19:04:39 +0800
Message-ID: <433D1BC7.6060301@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:22928 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030263AbVI3LE4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2005 07:04:56 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8UB4fCm019671
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:04:41 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8UB4fZQ081986
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:04:41 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j8UB4eLU018539
	for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 07:04:41 -0400
In-Reply-To: <58cb370e05092903083e0d001c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Dear all,

The irq driven PIO follow up patches per Bart's advice.

patch 1/4:
    - add comments for HSM_ST_*

  ata_qc_issue_prot():
    - remove the redundant code for the ATA_PROT_ATAPI case.

patch 2/4:
    - rename atapi_packet_task() to ata_dataout_task() and change comments

patch 3/4:
    - simplify if condition in ata_dataout_task():
      Use if (qc->tf.protocol == ATA_PROT_PIO) instead of 
is_atapi_taskfile()

patch 4/4:
  ata_qc_issue_prot():
    - let the PIO data out case always go through the ata_dataout_task() 
codepath.

  ata_dataout_task():
    - handle the PIO data out + polling case.

Patch against libata-dev irq-pio tree 
(e50362eccd8809a224cda5f71714a088ba37b2ab).

For your review and advice, thanks.

Albert

