Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B483976A0
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055137; cv=none; b=R55PcGyGSkRvxuu5PFfWucJtW9gEC2qXu0RaEi5YTzzAlCZKDz9HCG1UWoss7DTgKsdikgOChZtsF63IsCQV+58T2cRDLGDsvWzaQMiIWO84thXxPFM/l/ITzb+BxYVwu44ADMLRLCN/FOb9Xp8oz6f92ANRJZ6RtfZrSOIgRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055137; c=relaxed/simple;
	bh=XR9Iake1DCs4sC2o12xnejluMt7aunGuCOHzg2PIieA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vunugr9TNf7zeyFf8DW7N4A6KNUFJQv+9VMBQmcMw/d6U62n75OmpTH8t1D76KzGaPU8h5zetpsBRuPPa5DpXzxfpnW/eqXNc98jN5/tjiKlCZ0E+gnvsPevlanhUMXzKPYlCqYh/6lDpEVizplAOG0kwrHQ3+0HXec0u1bheds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CknlFYXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CknlFYXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFD11F000E9;
	Fri,  3 Jul 2026 05:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783055125;
	bh=Pd6MR9eLnt00iqWDb0ag9q+y/96mHecunz+CUJa3B0c=;
	h=From:To:Cc:Subject:Date;
	b=CknlFYXwBpPF/T8dK2T1TM9vSoRSzFQxjr/PbMxPD1iWkUjaXGkxr6093MTOs3aag
	 ARJtWoKqbCDYFUp3D1rWWvfxAtZ7PwWRj1IW+YiQnnEl1TK+2/f98l1EhKjQw5zxW0
	 musc+t9UkFeDO32WBHl61IW4Ed8boRa6g0bXN4RXzmGbCxrPC5RmS9YquklPE+hAhE
	 3TVg5FO8+hxkpmD/w6d81RweqxeLNCIno+jL7TmYtqGauNF/cLGMWYtS3lJw5RBWVp
	 3QBKgqWwpNMgsC/w2nU9ZfKO1cp820ycIL3/PcKRaTF1uToWsue8mhm+SYUqC67euk
	 aIz0z45o3Gn2w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.2-rc2
Date: Fri,  3 Jul 2026 14:05:13 +0900
Message-ID: <20260703050513.2276742-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 51512e22efe813d8223de27f6fd02a8a48ea2323:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2026-07-02 16:39:28 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc2

for you to fetch changes up to cd64be0ecd399fa2b1ab60b3aaf2b2b744243467:

  ata: libata-scsi: limit simulated SCSI command copy to response length (2026-07-03 13:44:18 +0900)

----------------------------------------------------------------
ata fixes for 7.2-rc2

 - Quirk the Phison PS3111-S11 SSD with NOLPM due to its defective link
   power management (Bryam).

 - Strengthen checks on a device concurrent positioning range
   information to make sure to reject any invalid report (Bryam).

 - Fix probe error handling in the pata_pxa and sata_gemini drivers
   (Myeonghun, Wentao).

 - Limit buffer size of replies from translated commands to what libata
   actually generated (Karuna)

----------------------------------------------------------------
Bryam Vargas (2):
      ata: libata-core: Add NOLPM quirk for PNY CS900 1TB SSD
      ata: libata-core: Reject an invalid concurrent positioning ranges count

Karuna Ramkumar (1):
      ata: libata-scsi: limit simulated SCSI command copy to response length

Myeonghun Pak (1):
      ata: sata_gemini: unwind clocks on IDE pinctrl errors

Wentao Liang (1):
      ata: pata_pxa: Fix DMA channel leak on probe error

 drivers/ata/libata-core.c | 21 +++++++++++++++++++++
 drivers/ata/libata-scsi.c |  9 ++++++---
 drivers/ata/libata.h      |  9 +++++++++
 drivers/ata/pata_pxa.c    |  1 +
 drivers/ata/sata_gemini.c |  2 +-
 5 files changed, 38 insertions(+), 4 deletions(-)
