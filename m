From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Host protected area on suspend/resume
Date: Tue, 12 Jul 2005 12:30:44 +0100
Message-ID: <20050712113044.GA8744@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.81.22]:46825 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261337AbVGLLbI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Jul 2005 07:31:08 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On boot, Linux will attempt to disable the host protected area on a 
disk. After a suspend/resume cycle, the BIOS may reenable it (seen on a 
Thinkpad T40 and R40). As a result, the kernel is now unable to access 
the HPA.

Is there any issue with just adding a call to idedisk_check_hpa() in the 
IDE resume code?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
