From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCH 0/3] AHCI updates: Marvell AHCI PATA works; =?utf-8?b?cGF0YV9tYXJ2ZWxs?= fate?
Date: Sun, 27 Dec 2009 05:13:07 +0000 (UTC)
Message-ID: <loom.20091227T054252-842@post.gmane.org>
References: <20090417023949.GA14469@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57497 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbZL0FPI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Dec 2009 00:15:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NOlT6-0003qg-Ry
	for linux-ide@vger.kernel.org; Sun, 27 Dec 2009 06:15:05 +0100
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com ([99.224.155.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 27 Dec 2009 06:15:04 +0100
Received: from rocketraman by CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 27 Dec 2009 06:15:04 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik <jeff <at> garzik.org> writes:
> This is an update of the recent libahci patchset, currently available
> on the 'libahci' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> [...]
> The mv-ahci code is obviously still a bit raw with "#if 0" in places,
> but it is nonetheless ready for testing.

I tested the libata-dev kernel as of commit c3939cc09. I had to comment out a 
bunch of code (for example, code related to the sntf board in ahci.c and some 
other stuff) and add a cap2 variable to the ahci_host_priv struct in ahci.h in 
order to successfully compile the branch.

I also had to comment out the pata_enable check in mv-ahci.c:mv_ahci_init_one in 
order to get the mv_ahci module to initialize my hardware, even though I have 
the pata_marvell module blacklisted.

My test hardware:

Intel D75XBX2 motherboard with 2 onboard SATA controllers
- ICH7 controller in AHCI mode
  - 3 disks (2 x ST3320620AS, 1 x ST3500418AS)
- Marvell 88SE6145 controller, using AHCI (ahci.marvell_enable=1)
  - 3 disks (3 x ST3500418AS)

I used "fio surface-scan" for my test (is that a good way to test this?) and I 
found no regressions from the stock Fedora 12 kernel 2.6.31.6-166.fc12.x86_64. 
However, I was hoping the latest libata-dev branch resolved this issue:

https://bugzilla.redhat.com/show_bug.cgi?id=549981

It did not. I continue to get the same error as described in my bugzilla report 
with libata-dev.

I hope that helps. I am willing to help out with other testing on this hardware, 
as necessary. Please cc me on replies.

Tested-by: Raman Gupta <rocketraman@fastmail.fm>

Cheers,
Raman Gupta


