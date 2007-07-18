From: Serguei Miridonov <mirsev@cicese.mx>
Subject: Kernel bug in Fedora 7.
Date: Tue, 17 Jul 2007 23:25:36 -0700
Message-ID: <200707172325.37021.mirsev@cicese.mx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hermes.cicese.mx ([158.97.1.34]:45951 "EHLO hermes.cicese.mx"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbXGRGpV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jul 2007 02:45:21 -0400
Received: from quantum.cicese.mx (quantum.cicese.mx [158.97.20.31])
	by hermes.cicese.mx (8.13.8/8.13.8) with ESMTP id l6I6Q5eO011053
	for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 23:26:06 -0700
Received: from localhost (quantum.cicese.mx [127.0.0.1])
	by quantum.cicese.mx (8.14.1/8.12.10) with ESMTP id l6I6PcgA005923
	for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 23:25:38 -0700
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Please, check http://bugzilla.kernel.org/show_bug.cgi?id=7674

Fedora 7 with current 2.6.21-1.3228.fc7 kernel has this bug. My 
hard drive clicks every shutdown in Fedora 7 and never had 
this with FC5 or Windows. This is serious bug.

Please, help as soon as possible.

Best regards,
Serguei Miridonov.

P.S. I could download the newer kernel 2.6.22 from kernel.org 
and compile it myself but I'm not sure if any additional 
patches were applied to 2.6.21 which is necessary for Fedora 
7.

P.P.S. I have read http://linux-ata.org/shutdown.html and I 
still can not understand your logic... What is needed just 
properly shutdown the system without any emergency heads 
unload... My understanding is that kernel has nothing to do 
with spin-up/spin-down disks. This is what shutdown or halt 
script have to do, unmounting filesystems, synchronizing cache 
with hdparm -f, and spin-down with hdparm -y if necessary. 
Then let the kernel just switch the power off.
