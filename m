From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/4] libata: CHS follow-up patches (resend #5)
Date: Tue, 11 Oct 2005 19:05:42 +0800
Message-ID: <434B9C86.604@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com> <434276B9.7080807@tw.ibm.com> <43427AFD.1020405@pobox.com> <4343B5F5.4090402@tw.ibm.com> <434509EF.3040307@pobox.com> <43461B81.1090808@tw.ibm.com> <43463296.3090007@tw.ibm.com> <43491E26.40508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:1969 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751445AbVJKLFy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Oct 2005 07:05:54 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9BB5ioA024095
	for <linux-ide@vger.kernel.org>; Tue, 11 Oct 2005 07:05:44 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j9BB5iM3120670
	for <linux-ide@vger.kernel.org>; Tue, 11 Oct 2005 07:05:44 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j9BB5iUc004706
	for <linux-ide@vger.kernel.org>; Tue, 11 Oct 2005 07:05:44 -0400
In-Reply-To: <43491E26.40508@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Jeff,

CHS follow-up patches. (Keep sync with the scsi error handling patch. Also added patch 3/4.)

patch 1/4: move the initialization of ATA_TFLAG_LBA and ATA_TFLAG_LBA48 flags to the SCSI translation functions

patch 2/4: calculate read/write commands and protocols on the fly

patch 3/4: reread device identify info after initializing device CHS settings

patch 4/4: LBA28/LBA48 optimization

Patch against libata-dev upstream branch
(edea3ab58f8edd5f72d31f891ab4f34382e97e3a).

For your review, thanks.

Albert
