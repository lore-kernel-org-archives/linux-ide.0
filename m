From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/4] libata: Workaround/fixes for ATAPI devices (take 3)
Date: Mon, 02 Apr 2007 11:26:04 +0800
Message-ID: <461077CC.4040708@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:42651 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbXDBD0U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Apr 2007 23:26:20 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l323QG9c004444
	for <linux-ide@vger.kernel.org>; Sun, 1 Apr 2007 23:26:16 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l323QFbJ194738
	for <linux-ide@vger.kernel.org>; Sun, 1 Apr 2007 21:26:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l323QFtO022826
	for <linux-ide@vger.kernel.org>; Sun, 1 Apr 2007 21:26:15 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>

patch 1/4: Reorder HSM_ST_FIRST
patch 2/4: Clear tf before doing request sense
patch 3/4: Limit max sector to 128 for TORiSAN DVD drives
patch 4/4: Limit ATAPI DMA to R/W commands only for TORiSAN DVD drives

(patch 2/4 revised per Tejun's advice.)
(patch 3/4 revised per Vlad's new test result.)

