From: "Bhartiya Anju-B07263" <B07263@freescale.com>
Subject: FW: PMP hot plug issue in kernel
Date: Tue, 24 Nov 2009 18:58:04 +0530
Message-ID: <0BFAB844762735448F252416AE17AB5E0124ED43@zin33exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:51064 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbZKXN2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Nov 2009 08:28:01 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id nAODS6hO007630
	for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2009 06:28:07 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net [10.232.192.22])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAODWJkp006619
	for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2009 07:32:20 -0600 (CST)
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

 
	 Hi All,

		 
		Recently came across an issue which is decribed below.
		 
		Setup: Port Multiplier with 2 HDD's connected to it;
Port multiplier is connected to a SATA port of the Host Controller.
		 
		Test: HDD1 is mounted and using dd command a file of
size 512MB is being written on it.
		Command: time sh -c "dd if=/dev/zero of=/mnt/hd/ddfile
bs=1k count=512000 && sync"
		 
		While this command is running, if the second HDD on PMP
is plugged out, the R/W speed of the first HDD gets affected.
		Please see the results of experiments on 2.6.31 kernel.
		 
		Plug Out	 	 	
		real    0m34.433s
		user    0m0.932s
		sys     0m21.352s	 

		Plug in
		real    0m23.726s
		user    0m0.908s
		sys     0m21.388s	 

		Normal
		real    0m23.329s
		user    0m1.132s
		sys     0m20.968s	
		 
		The results are similiar with multiple Port Multipliers
(Si3726, Si4726 and EXAR PMP) and multiple Host controllers (Si3132  and
sata_fsl).
		 
		As the behaviour with multiple Host controllers and Port
Multipliers is the same so this seems to be an issue with libata stack.
		Is there already a patch for this issue? Any pointers or
help to fix this will be greatly appreciated.
		 
		Best Regards,
		Anju
		Applications Engineer 
		Freescale Semiconductor

