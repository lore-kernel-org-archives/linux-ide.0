From: Tejun Heo <tj@kernel.org>
Subject: Re: [GIT PULL] libata fixes for v4.1-rc7
Date: Mon, 8 Jun 2015 18:10:51 +0900
Message-ID: <20150608091051.GF21465@mtj.duckdns.org>
References: <20150608061905.GE21465@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35415 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbFHJK6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jun 2015 05:10:58 -0400
Content-Disposition: inline
In-Reply-To: <20150608061905.GE21465@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

(updated with one more patch)

Hello,

Contains two driver fixes.  One is for ahci_mvebu controller config
bug and the other fixes pata_octeon_cf build issue.

Thanks.

The following changes since commit dbfe8ef5599a5370abc441fcdbb382b656563eb4:

  ahci: avoton port-disable reset-quirk (2015-05-10 11:39:16 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.1-fixes

for you to fetch changes up to 4710f2facb5c68d629015747bd09b37203e0d137:

  pata_octeon_cf: fix broken build (2015-06-08 18:03:04 +0900)

----------------------------------------------------------------
Aaro Koskinen (1):
      pata_octeon_cf: fix broken build

Nadav Haklai (1):
      ata: ahci_mvebu: Fix wrongly set base address for the MBus window setting

 drivers/ata/ahci_mvebu.c     | 2 +-
 drivers/ata/pata_octeon_cf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--
tejun
