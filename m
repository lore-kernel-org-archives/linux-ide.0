From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHBOMB] libata: Port Multiplier support
Date: Sun, 1 Jul 2007 18:30:15 +0900
Message-ID: <20070701093015.GU29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:49756 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755395AbXGAJaU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:30:20 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1870847wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:30:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Hello, all.

I'm about to post an updated version of PMP support.  Well, as always,
it took longer than I expected but it's complete now and looking good.
It's composed of the following four patchsets.

1. misc-updates patchset : This patchset contains 12 patches which
   updates various stuff.  A few are just improvements found during
   PMP work.  Others are related to PMP support in indirect way.  All
   patches in this patchset are independent.

2. pmp-link patchset : This patchset contains 16 patches which
   implement a new abstraction layer - ata_link - to represent the ATA
   link or PHY.  PMP bascially adds a bunch of PHYs to the host and it
   is represented by multiple ata_links associated with a host.  After
   this patchset, all parts are ready to deal with multiple links per
   host.

3. libata-pmp-prep patchset : This patchset contains 11 patches
   implementing features to be used by PMP support including qc_defer
   mechanism and link quirks.

4. libata-pmp: This patchset contains 11 patches implementing core PMP
   functionality and PMP support in sata_sil24 and ahci.

One of the biggest changes from the last time is lack of
hotplug-by-polling.  hp-poll needs more work and is pushed back
accordingly.  AHCI PMP support is also added.

Each patchset contains detailed description including list of changes
from the last take.  All in all, this patchset behaves much better EH
wise compared to the previous take.  SIMG 3726/4726 quirks are now
properly handled and except for some corner cases for 4726 which I
don't think there exists a solution, they always behave pretty good
(oh well mines, at least).  New SIMG 5744 also works well.

Thanks.

--
tejun
