From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/4] libata: Workaround/fixes for ATAPI devices (revised)
Date: Sat, 31 Mar 2007 16:02:14 +0800
Message-ID: <460E1586.2000603@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:55911 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbXCaICY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 04:02:24 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l2V80KAr028622
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 04:00:20 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2V82OlI009128
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 02:02:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2V82NAj006479
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 02:02:24 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, Linux IDE <linux-ide@vger.kernel.org>

patch 1/4: Reorder HSM_ST_FIRST
patch 2/4: Clear tf before doing request sense
patch 3/4: Limit max sector to 240 for TORiSAN DVD drives
patch 4/4: Limit ATAPI DMA to R/W commands only for TORiSAN DVD drives

(patch 2/4 revised per Tejun's advice.)

