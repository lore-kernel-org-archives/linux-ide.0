From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple PowerMac/PowerBook IDE controller
Date: Thu, 3 Dec 2009 16:10:42 +0100
Message-ID: <19223.54514.333777.229238@pilspetsen.it.uu.se>
References: <20091202003630.29919100851@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:2256 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756325AbZLCPKn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Dec 2009 10:10:43 -0500
In-Reply-To: <20091202003630.29919100851@ozlabs.org>
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
 > v2. Better tested now, seems to be reasonably solid.
 > 
 > Addressed Tejun comments and made remove more robust vs. media-bay,
 > should also fix Andreas problem.

Tested in 2.6.32-rc8 and 2.6.32 final on a G4 eMac.
Works fine, except for the yaboot problem:

> /sbin/installkernel 2.6.32 vmlinux System.map 
ofpath: Driver:  is not supported
ybin: Unable to find OpenFirmware path for boot=/dev/sda2
ybin: Please add ofboot=<path> where <path> is the OpenFirmware path to /dev/sda2 to /etc/yaboot.conf
ofpath: Driver:  is not supported
ybin: Unable to determine OpenFirmware path for macosx=/dev/sda4
ybin: Try specifying the real OpenFirmware path for macosx=/dev/sda4 in /etc/yaboot.conf

(userspace is YDL 6.2)

/Mikael
