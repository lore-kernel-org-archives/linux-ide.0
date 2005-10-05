From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/4] libata: more CHS follow-up patches
Date: Wed, 05 Oct 2005 19:16:05 +0800
Message-ID: <4343B5F5.4090402@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com> <434276B9.7080807@tw.ibm.com> <43427AFD.1020405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54239 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932612AbVJELQm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 07:16:42 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j95BGSS0030792
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2005 07:16:28 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j95BGS08104486
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2005 07:16:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j95BGR8W014093
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2005 07:16:28 -0400
In-Reply-To: <43427AFD.1020405@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Dear all,

More CHS follow-up patches:

patch 1/4: move the initialization of ATA_TFLAG_LBA and ATA_TFLAG_LBA48 
flags to the SCSI translation functions

patch 2/4: calculate read/write commands and protocols on the fly

patch 3/4: support overriding the ata_rwcmd_protocol() function

patch 4/4: optimize LBA28/LBA48 usage

Patch against libata-dev upstream branch 
(643736a58d2668af94aee05670c5e9ae76e7b85f).

For your review and advice, thanks.

Albert



