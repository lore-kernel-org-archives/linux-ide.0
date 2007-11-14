From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Wed, 14 Nov 2007 17:46:26 +0100
Message-ID: <200711141746.26793.ak@suse.de>
References: <198606.73895.qm@web52608.mail.re2.yahoo.com> <200711141317.35746.ak@suse.de> <alpine.LFD.0.9999.0711141633400.3265@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35914 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755934AbXKNQqb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 11:46:31 -0500
In-Reply-To: <alpine.LFD.0.9999.0711141633400.3265@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

 
> The AHCI code falls back to 32bit DMA in that case. Which in turn
> causes the problem seen by Srihari. There is not much printk sticking
> necessary, the code is simply not handling this. 

What code is not handling what? 

IOMMU merging should be always safe. If it is not the driver should
not submit things in a single SG list.

> So the main option 
> right now seems to revert the iommu_merge patch.

I don't think that is the correct fix.

-Andi
 
