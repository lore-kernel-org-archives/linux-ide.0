From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM II
Date: Tue, 20 Nov 2007 17:36:02 +0100
Message-ID: <200711201736.02957.ak@suse.de>
References: <198606.73895.qm@web52608.mail.re2.yahoo.com> <47423245.1050109@gmail.com> <alpine.LFD.0.9999.0711201559520.25057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:47846 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755413AbXKTQgH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Nov 2007 11:36:07 -0500
In-Reply-To: <alpine.LFD.0.9999.0711201559520.25057@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <htejun@gmail.com>, Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>


> Which in turn enables the iommu_merge functionality in gart_map_sg().

> 	for_each_sg(sg, s, nents, i) {

Hmm, another thought. Maybe this code just has trouble with the new 
linked SG lists and it's not really a SB600 problem?

I did a quick test on two ATI machines with older chipset and iommu=force,merge
and it didn't show a problem though.

-Andi
