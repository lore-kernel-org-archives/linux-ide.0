From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/3] libata-dev: use PageHighMem() to optimize kmap_atomic()
 usage
Date: Fri, 07 Oct 2005 14:08:35 +0800
Message-ID: <434610E3.4090701@tw.ibm.com>
References: <43438258.9080706@pobox.com> <4344FDED.1080402@tw.ibm.com> <4345089A.9020006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:52407 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751376AbVJGGIm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2005 02:08:42 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9768gqe002531
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:08:42 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j9768gXV075998
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:08:42 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j9768fhQ027728
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:08:42 -0400
In-Reply-To: <4345089A.9020006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

(Resend due to white space mangled in the previous patches)

   patch 1/3: reorganize ata_pio_sector() and __atapi_pio_bytes()
   patch 2/3: reorganize "buf + offset"
   patch 3/3: use PageHighMem() to optimize the kmap_atomic() usage

Patch against libata-dev irq-pio branch (c71c18576d0d8aa4db876c737c3c597c724cf02f).
Thanks,

Albert



