From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/4] libata: Workaround/fixes for ATAPI devices
Date: Sat, 31 Mar 2007 15:07:27 +0800
Message-ID: <460E08AF.8070900@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:47900 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbXCaHHm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 03:07:42 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2V77fQR018971
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 03:07:41 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2V77fde169834
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 01:07:41 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2V77er7005026
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 01:07:41 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, IDE Linux <linux-ide@vger.kernel.org>

patch 1/4: Reorder HSM_ST_FIRST
patch 2/4: Clear tf before doing request sense
patch 3/4: Limit max sector to 240 for TORiSAN DVD drives
patch 4/4: Limit ATAPI DMA to R/W commands only for TORiSAN DVD drives

