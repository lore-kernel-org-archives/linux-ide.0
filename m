Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C24779E9
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804114; cv=none; b=cZquHrPSAuEYcTtN3uIVmd8KXs5UzaPZGkL6+Sq3BjUxvNlh+KBcWUEynF+KDCh5htKUtQObua6vv+IpXWKCs7Ycm2FnjUU0s7B5SwCXleeByVVX6aRHDz7XFFAf2njgP63teMeDvu8nz4dkw7WZKeQvCWyYbOv3Qsey0SWYXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804114; c=relaxed/simple;
	bh=D3rrIc2rRazaJGMNRmGlS3XRE8sUXRQrJDLO06XVgw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TeTgIPeeMgyAapgptlGu6JEotcptcrC0AjDGUTlEr2/2zc3kALPbYOswAC67tJ5Z/vM1AAZaHksxkNTFEZdmvDZR7ax3YlxjzE6aF6j62Zp0QbNCL9+CC8kmYn76r65303pPPWxi/xrt3Bbeq9hWgYCM+S4iaPuVjGe6OLYFsMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi1fA/27; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi1fA/27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534B9C433C7;
	Thu,  1 Feb 2024 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804113;
	bh=D3rrIc2rRazaJGMNRmGlS3XRE8sUXRQrJDLO06XVgw4=;
	h=From:To:Cc:Subject:Date:From;
	b=Oi1fA/27LDI1REYhFyEVBMZoCW99sP8vy8oTRWr4wWW7W9hMRTKEwYhsuvXmRx3Ob
	 kKgdS98Do6FKkSrdxzvcz43JpScMF/qfTAI65WjrRNKS0QGuENnP82sa+I/dJud5PM
	 K4ZFhXQqR+1VSxdNDzVj7K/oww/ZW8K5S1ITN2RYjIzNjatIUCGd6NCfyoavJWVx25
	 MNkTFxp8Np+o5VmMxHIlwEcriqH7PspqJqPRjxl1MGVqA/FjENQVUmDsA1OqAQrWby
	 bwEUQmS+njBZA0liUOHtpS59f1tybDOmy/EdgN1V0Y9jZS7YyhyM81pMun0eyhQsqd
	 45o41UyvWrPyA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	linux-ide@vger.kernel.org
Subject: [PATCH 0/5] drop low power policy board type
Date: Thu,  1 Feb 2024 17:14:57 +0100
Message-ID: <20240201161507.1147521-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is based on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next


Hello all,

This revives a patch sent out almost two years ago from Mario Limonciello:
https://lore.kernel.org/linux-ide/20220524170508.563-1-mario.limonciello@amd.com/T/#u

The reason why we did not merge it back then, is because LPM and hotplug
events are mutually exclusive.

The difference with this series compared to what was sent out back then:
I've added a patch that checks if the port is external, i.e. either
hotplug capable or eSATA. For external ports, we never enable LPM, as
that will break hotplug.

For ports that do not advertise themselves as external (typically laptops),
we set the LPM policy as requested.

This matches how Microsoft Windows does things.
Thanks to Werner Fischer for suggesting something like this at last year's
ALPSS conference.

There might of course be some platform firmware that e.g. incorrectly marks
its port as internal, even though it is external, but if we find any such
platforms we will need to deal with them using quirks.


Also note that we even if the user requested a certain policy, there is
no guarantee that he will get all the features for that policy, see:
https://github.com/torvalds/linux/blob/master/drivers/ata/libata-sata.c#L403-L414

However, I'd rather we not try to map all the combinations of
partial/slumber/devsleep in to a single policy represented by a single
integer, thus I do not try to "change" the requested policy.
The user will get all the features that are included in the requested
policy AND supported by the HBA.

Another difference (compared to an earlier version of Mario's series)
is that we do not try to change the default CONFIG_SATA_MOBILE_LPM_POLICY
value from 0 to 3, it will continue to be 0.
If you really don't want LPM even if your HBA supports it, and your port
is internal, one option is to leave the Kconfig set to the default value.

Note: in current mainline, there is an issue related to Intel VMD
which causes the link to not come up when VMD is enabled.
(The link does comes up when VMD is disabled in BIOS.)
In order to not get a bunch of bug reports related to LPM, we probably
want to wait with this series until we have fixed the VMD bug.


Kind regards,
Niklas


Mario Limonciello (1):
  ata: ahci: Drop low power policy board type

Niklas Cassel (4):
  ata: ahci: move marking of external port earlier
  ata: ahci: a hotplug capable port is an external port
  ata: ahci: drop hpriv param from ahci_update_initial_lpm_policy()
  ata: ahci: do not enable LPM on external ports

 drivers/ata/Kconfig   |   5 +-
 drivers/ata/ahci.c    | 134 +++++++++++++++++++++++-------------------
 drivers/ata/ahci.h    |   9 +--
 drivers/ata/libahci.c |   7 ---
 4 files changed, 77 insertions(+), 78 deletions(-)

-- 
2.43.0

