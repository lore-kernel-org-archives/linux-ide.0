From: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: RE: [PATCH v3] drivers/ata: add support to Freescale 3.0Gbps SATA Controller
Date: Wed, 17 Oct 2007 10:09:41 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5A30@zch01exm26.fsl.freescale.net>
References: <1192539518-6642-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:49328 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758809AbXJQCKF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2007 22:10:05 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9H29iAf000025
	for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 19:10:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9H29guQ019387
	for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 21:09:43 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <1192539518-6642-1-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Li Yang-r58472 <LeoLi@freescale.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: arnd@arndb.de, Kalra Ashish-B00888 <ashish.kalra@freescale.com>

> -----Original Message-----
> From: Li Yang-r58472 
> Sent: Tuesday, October 16, 2007 8:59 PM
> To: jgarzik@pobox.com; linux-ide@vger.kernel.org
> Cc: arnd@arndb.de; Li Yang-r58472; Kalra Ashish-B00888
> Subject: [PATCH v3] drivers/ata: add support to Freescale 
> 3.0Gbps SATA Controller

Sorry, forgot this line. :)

From: Ashish Kalra <ashish.kalra@freescale.com>

> 
> This patch adds support for Freescale 3.0Gbps SATA Controller 
> supporting
> Native Command Queueing(NCQ), device hotplug, and ATAPI.  
> This controller
> can be found on MPC8315 and MPC8378.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
