From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Tue, 20 Nov 2007 16:44:25 +0100
Message-ID: <200711201644.25615.ak@suse.de>
References: <198606.73895.qm@web52608.mail.re2.yahoo.com> <47423245.1050109@gmail.com> <alpine.LFD.0.9999.0711201559520.25057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:34250 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757635AbXKTPob (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Nov 2007 10:44:31 -0500
In-Reply-To: <alpine.LFD.0.9999.0711201559520.25057@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <htejun@gmail.com>, Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org


> This requires propably working 64bit DMA, which is not possible with
> the SB600 controller.

It should not no. The remapping is done into the GART which is <4GB
and that is the address the SB600 sees.

-Andi
