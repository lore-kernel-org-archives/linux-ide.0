From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/4] libata: CHS follow-up patches
Date: Tue, 04 Oct 2005 20:22:29 +0800
Message-ID: <43427405.80502@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63391 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750809AbVJDMWo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 08:22:44 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j94CMcZw015150
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:22:38 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j94CMc6C092232
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:22:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j94CMbbC011066
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:22:38 -0400
In-Reply-To: <4342706B.3030608@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Dear all,

CHS follow-up patches:

patch 1/4: white space, comments and debug message beautification

patch 2/4: tidy up SCSI lba and transfer length calculation

patch 3/4: add CHS support to ata_scsi_start_stop_xlat()

patch 4/4: calculate LBA28/LBA48 commands and protocol on the fly

Patch against libata-dev upstream branch 
(a1213499b0ef75d8c627b461047805a235c9dd00).

For your review and advice, thanks.

Albert

