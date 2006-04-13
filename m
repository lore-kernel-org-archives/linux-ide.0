From: Brian King <brking@us.ibm.com>
Subject: [PATCH 0/4] Prepare for SAS support
Date: Thu, 13 Apr 2006 14:51:42 -0500
Message-ID: <443EABCE.6000605@us.ibm.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33475 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964827AbWDMTwJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 15:52:09 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3DJpwhc013907
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 15:51:58 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3DJpmWw231046
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 15:51:48 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3DJplPu016616
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 15:51:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff,

Here are a few patches against #upstream in preparation for
adding support for attaching SATA devices via libata to
SAS HBAs without a host_set. The first two patches have
been submitted before, the second two are new. 

Thanks

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
