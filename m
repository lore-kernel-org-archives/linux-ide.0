From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple PowerMac/PowerBook IDE controller
Date: Tue, 1 Dec 2009 11:48:09 +0100
Message-ID: <19220.62569.492975.964154@pilspetsen.it.uu.se>
References: <20091201070834.6A840B7B63@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:59225 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbZLAKsM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 05:48:12 -0500
In-Reply-To: <20091201070834.6A840B7B63@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org, tj@kernel.org

Benjamin Herrenschmidt writes:
 > This is a libata driver for the "macio" IDE controller used on most Apple
 > PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
 > 
 > It supports all the features of its predecessor, including mediabay hotplug
 > and suspend/resume. It should also support module load/unload.
 > 
 > The timing calculations have been simplified to use pre-calculated tables
 > compared to drivers/ide/pmac.c and it uses the new mediabay interface
 > provided by a previous patch.
 > 
 > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
 > ---
 > 
 > Only lightly tested so far, this is for review, NOT for merge.
 > 
 > I would like to merge it eventually via the powerpc tree since there's a
 > few dependent patches, though I would need the libata "fix" for
 > bmdma_stop to go in first, unless I carry it as well with appropriate
 > acks.
 > 
 > I have addressed some of the comments from the previous version (almost a
 > year ago I think). I have kept the single function for the PIO and DMA
 > timings due to the one bit overlap between the fields in the HW register
 > on the shasta chipset. It seems to work fine.

Thanks for reviving pata_macio.

Does the new version work with yaboot? (the previous one didn't)

/Mikael
