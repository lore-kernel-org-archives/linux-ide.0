From: Brian King <brking@us.ibm.com>
Subject: [PATCH 0/3] libata: SAS HBA support resend of ACK'ed patches
Date: Thu, 23 Mar 2006 17:29:55 -0600
Message-ID: <44232F73.9050801@us.ibm.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47318 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932557AbWCWX35 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2006 18:29:57 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2NNTusP022327
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 18:29:56 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2NNTu21182136
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 18:29:56 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2NNTuha030388
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 18:29:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff,

Here is a resend of the three patches in my SAS HBA support
patchset you have ACK'ed so far. (I was assuming you wanted
a resend since you ACK'ed them rather than just directly
applying them. If not, sorry for the noise.)

Thanks

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
