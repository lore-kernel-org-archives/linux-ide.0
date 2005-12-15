From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problems in the SiS IDE driver
Date: Thu, 15 Dec 2005 22:18:08 +0000
Message-ID: <1134685088.20495.2.camel@localhost.localdomain>
References: <1134587705.25663.67.camel@localhost.localdomain>
	 <20051214211216.GA6045@corona.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:29395 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751122AbVLOWRz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Dec 2005 17:17:55 -0500
In-Reply-To: <20051214211216.GA6045@corona.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mer, 2005-12-14 at 22:12 +0100, Vojtech Pavlik wrote:
> > And timing can be zero....
> > 
> > Would be useful to know if this is a bug, and also what the correct
> > behaviour is at this point as I don't have all the SiS data sheets.
> 
> This is a bug - test1 should be initialized to 0.

Thanks. Will fix that in the pata_ version. The MWDMA support for some
chips also appears to be missing (it doesn't load timing values at all
and it doesn't do PIO/MWDMA setup timing checks).


Alan
