From: Mat Loikkanen <Mat.Loikkanen@synopsys.com>
Subject: AHCI FBS - Software Reset - BUG
Date: Wed, 18 Jan 2012 09:47:17 -0800
Message-ID: <ABC6CE68F7ADB04BBE390362142C0CF39A73BF4C@US01WXMBX1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:61296 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2ARRrT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2012 12:47:19 -0500
Received: from crone.synopsys.com (crone.synopsys.com [146.225.7.23])
	by kiruna.synopsys.com (Postfix) with ESMTP id 9696D10AD7
	for <linux-ide@vger.kernel.org>; Wed, 18 Jan 2012 09:47:18 -0800 (PST)
Received: from us01wxhtc3.internal.synopsys.com (localhost [127.0.0.1])
	by crone.synopsys.com (8.9.1/8.9.1) with ESMTP id JAA12003
	for <linux-ide@vger.kernel.org>; Wed, 18 Jan 2012 09:47:18 -0800 (PST)
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I believe I've run into what appears to be a bug in the Linux kernel AHCI driver, related to operation with port multipliers when FBS enabled.  It has to do with the issuing of Software Resets (SRST) to a PM control port or device ports.  The issue has been observed in 3.1.2 and in 3.2.

-	As per AHCI spec 1.3 section 9.3.9, PxFBS.EN is to be cleared to 0 when sending SRST as part of PM device enumeration.  libahci.c ahci_do_softreset() does not seem to comply with this.  DISABLING FBS DURING SRST IS THE RIGHT FIX FOR THIS PROBLEM, IN MY OPINION.

-	As per AHCI spec 1.3 section 9.3.8, The R-bit in the Command Header is not to be set when PxFBS.EN=1.  The R-bit is in fact set for the first SRST FIS.  libahci.c does not seem to comply with this.  

-	libahci.c does not set PxFBS.DEV with the pmp in ahci_do_softreset()-call to ahci_exec_polled_cmd() does not set PxFBS.DEV.  (This would not matter if the driver cleared PxFBS.EN for SRST.)

-	The problem symptom is that with some controllers the PxTFD and PxCI registers are not updated when the D2H Reg FIS is received for the SRST.  As per AHCI spec 1.3 section 5.3.5.3 (state NDR:Accept) if pBsy[pPmpCur]=0 and pDrq[pPmpCur]=0 the state transition is to P:Idle and PxTFD/PxCI are not updated.  pPmpCur is the pmp in the D2H.  pBsy[] and pDrq[] are controller states set based on PxFBS.DEV at time of command issue.  The Linux AHCI driver goes into EH a number of times before failing and detaching the PM because of this.  

Cheers,
-mat
