From: Brian King <brking@us.ibm.com>
Subject: libata/sas patches
Date: Mon, 22 May 2006 09:35:01 -0500
Message-ID: <4471CC15.8000102@us.ibm.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:44965 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750863AbWEVOfU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 10:35:20 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4MEZ50C002851
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 10:35:05 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4MEZ5mQ054552
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 10:35:05 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4MEZ3Oc010107
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 10:35:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I just uploaded my updated libata patchset to support attaching
SATA devices to SAS HBAs. It's only lightly tested at this point.
I still need to give it another review myself and make sure
I'm happy with all the error cases, but the base function
is working for me, so I figured I'd post the link. I'll
hopefully submit the code to the list soon.

http://prdownloads.sourceforge.net/iprdd/ipr-sata.tgz?download


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
