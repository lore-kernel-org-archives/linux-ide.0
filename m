Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4020B35
	for <linux-ide@vger.kernel.org>; Sat, 13 Apr 2024 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712996134; cv=none; b=pUILdqZ8dnqTs9fXmTop2Y955CVqZse5dFG5WCzOLGj1DwNMMO73RV6Cctf+3tV6MU854B6rTfMu5pmGkCGXs/VTKsdevDUy8a/vMLUW3Mn0yso+igRThHrfG5UAqThVYSEhkvheo7PDygpF3YQKJ9cy+F1wD3PNq2Le9uN2SQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712996134; c=relaxed/simple;
	bh=zRB6BtCci9zCCAMa4WFUQfRLFemphAGK4YiuTSk2VaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOOMg99fmq1nV7QlSstMShPLFq2vwpHld9KBOijuCWkW/rmvLZMpSTcsPoVb9NeYNG3hXP55NTpP5i1iT4XY7TsW7SuUKCY0pQGahGXMn3dbVd6xzWMia6P0K5dZ64q1bFcUqK4DwYi78+PkBWclnwK1Dg4YQL7msyLOv0cA4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPNF33D7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPNF33D7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAF4C113CD;
	Sat, 13 Apr 2024 08:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712996133;
	bh=zRB6BtCci9zCCAMa4WFUQfRLFemphAGK4YiuTSk2VaY=;
	h=From:To:Cc:Subject:Date:From;
	b=oPNF33D79zj3+uh1jKIrSzEVh8NSouGsdabKokGNxmwKHBL3TJG2q5tWFYfFjbNkP
	 N8orPPh5du+Pc3tiib0eDWDFJ/W75daauQy5/9QblEDkZvsL21syXcGBUI1lRdfWwt
	 j21tWHaeztSujtzVj88x6pcUPA+AdW/tp77RGdDB5s16MHSmn9s75KsH8V5JyOs2S5
	 SP6+pme25vPEHnWj5NoSAULspE5jJRO9RwBiRiBDCqJN+ccfYALz50609dDBPUzDSZ
	 ZSjk2EhcgvYxe0nsv5uJvQv/AQYW1vgJQchzhw1RKoTj2kKNv3SRrC/D6j5z+7mVwn
	 +YQG8L1oH/bpw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.9-rc4
Date: Sat, 13 Apr 2024 17:15:31 +0900
Message-ID: <20240413081531.1158825-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit e85006ae7430aef780cc4f0849692e266a102ec0:

  ata: sata_gemini: Check clk_enable() result (2024-04-04 12:42:00 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc4

for you to fetch changes up to c0297e7dd50795d559f3534887a6de1756b35d0f:

  ata: libata-core: Allow command duration limits detection for ACS-4 drives (2024-04-13 10:42:28 +0900)

----------------------------------------------------------------
ata fixes for 6.9-rc4

 - Add the mask_port_map parameter to the ahci driver. This is a
   follow-up to the recent snafu with the ASMedia controller and its
   virtual port hidding port-multiplier devices. As ASMedia confirmed
   that there is no way to determine if these slow-to-probe virtual
   ports are actually representing the ports of a port-multiplier
   devices, this new parameter allow masking ports to significantly
   speed up probing during system boot, resulting in shorter boot times.

 - A fix for an incorrect handling of a port unlock in
   ata_scsi_dev_rescan().

 - Allow command duration limits to be detected for ACS-4 devices are
   there are such devices out in the field.

----------------------------------------------------------------
Damien Le Moal (2):
      ata: ahci: Add mask_port_map module parameter
      ata: libata-scsi: Fix ata_scsi_dev_rescan() error path

Igor Pylypiv (1):
      ata: libata-core: Allow command duration limits detection for ACS-4 drives

 drivers/ata/ahci.c        | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c |  2 +-
 drivers/ata/libata-scsi.c |  9 ++---
 3 files changed, 91 insertions(+), 5 deletions(-)
