From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.7] new NVIDIA libata SATA driver
Date: Wed, 16 Jun 2004 21:22:19 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040617012219.GA11167@havoc.gtf.org>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B4@mail-sc-6-bk.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:58338 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266346AbUFQBWU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2004 21:22:20 -0400
Content-Disposition: inline
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B4@mail-sc-6-bk.nvidia.com>
List-Id: linux-ide@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Jun 16, 2004 at 06:19:34PM -0700, Andrew Chew wrote:
> > From: Bartlomiej Zolnierkiewicz 
> 
> > Is there any reason why this driver doesn't support 
> > CK804-SATA[2] and  MCP04-SATA[2]?
> 
> These will be supported by this driver eventually.  We probably can
> change it now, but silicon isn't available for these yet so I wasn't
> able to test the driver.

If silicon isn't available yet, let's just remove those PCI IDs.  That
way we can ensure that these are libata only, without two drivers
sharing the same PCI ids.


> > Removing IDs from amd74xx.c is a bad idea,
> > it breaks boot on systems already using these IDs.
> 
> I assume these systems will be able to boot using the libata subsystem.
> Is that a bad assumption?

They can, but consider a system that uses 2.6.7 (IDE driver) then boots
into 2.6.8 (libata driver):  the drives move from /dev/hdX to /dev/sdX.
That breaks stuff not using LABEL= in bootloader config and fstab.

	Jeff



