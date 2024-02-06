Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF61B942
	for <linux-ide@vger.kernel.org>; Tue,  6 Feb 2024 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254053; cv=none; b=Nga/4/dfa+0U65ECW3pXHYRXlFsNADBDv1bPjUTAXdGUxogLrgs2C0ahgU/EXjtMaI/AhPYkiGUIRruUp8vCCZWiNxegQUjQnoaRMNRg7nPrH6bOcDlqzPgX1IF4eX+TwI5j0hjmEE7jTLK3H4qUfLThBC48yDEPI5HzI98TjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254053; c=relaxed/simple;
	bh=+fHjn2hZCGVXN4jHrX3ddEVXHTNtjbin+EE5y8EEdOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=utXd1/cRc+hcPIYidriuNIYo6395pBX/Saes0qA3gxEATpAHgh4r9IzOgvs2vXKNm+cn5llJeBZ8/iYU+0jxmZb0rv3rnUyoPa9p04ST6+I+otXynrH5XKPiV3Ytyo1hwGpZg66+kXeUzLjgyp0L8Ig8k2BfNckNpifIhiv36LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZF7n3vo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZF7n3vo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680E0C433F1;
	Tue,  6 Feb 2024 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707254052;
	bh=+fHjn2hZCGVXN4jHrX3ddEVXHTNtjbin+EE5y8EEdOw=;
	h=From:To:Cc:Subject:Date:From;
	b=LZF7n3voCCP6DdqSlWSry93bd7M4+PF5szDQK88KC/YXFkiE1ATapk3DWrWW8wXTw
	 04425ezx1p+8KLPEUd6KT7NN5+fPTfWtzp1RzavvWqkxmAIWKOsQSQS4BAXIu6sUHN
	 Oo+5U2ni4Jtq+TYW6q18aa0q/2TsGLqbuUH2DiLMsDV8oZ2jldk8KVnDvAaavKRS/w
	 N4QjnXTLvJrAZXk9r8lGcqIghxVF0WKNDOp4yBh7rKSjHbAhOIQdQberzh+eebMP7G
	 KocEWoXHlu324P16fJmXwap1jj00CVyNFaB/wW+h8DV2NFxx5AmpNEfEugn4eE9IX7
	 EdUy769OK/Wrw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 0/5] drop low power policy board type
Date: Tue,  6 Feb 2024 22:13:41 +0100
Message-ID: <20240206211352.1664816-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This matches how Microsoft Windows does things, see:
https://studylib.net/doc/10034428/esata---microsoft-center

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

Damien: considering that the Intel VMD + ahci_intel_pcs_quirk() bug turned
out to have nothing to do with LPM, it was simply the fact that the
ahci_intel_pcs_quirk() was only applied if there was an explicit entry in
ahci_pci_tbl. So since that bug is totally unrelated to LPM, I no longer
think that this series need to wait for a fix for that bug.


Link to v1:
https://lore.kernel.org/linux-ide/20240201161507.1147521-1-cassel@kernel.org/

Changes since v1:
-Picked up tags from Damien.
-Moved the comment in front of ahci_mark_external_port() to inside the
 function.
-Modified the comment in patch 4/5 to more clearly state hotplug removal
 events.
-Rewrote the commit message for patch 4/5 to be more detailed.


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
 drivers/ata/ahci.c    | 135 +++++++++++++++++++++++-------------------
 drivers/ata/ahci.h    |   9 +--
 drivers/ata/libahci.c |   7 ---
 4 files changed, 78 insertions(+), 78 deletions(-)

-- 
2.43.0

