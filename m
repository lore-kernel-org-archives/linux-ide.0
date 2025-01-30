Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622E1E412A;
	Thu, 30 Jan 2025 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244157; cv=none; b=W5RKqOBAomwNRKYjE+XeSH2rMgb9ZMqzQag0rrHSJh3p63jC0Q5Ov9obLzwR5hf6yNfMQ9vy3XcC4eBctz+E4PspIi/dlqr6BA0eZdmcinZeqJCpjjGdQMzOXCADiMcQXnJSg99EhKdJOkIHEndEujOEBg+MXl2SiCSFxWS2j0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244157; c=relaxed/simple;
	bh=cL2E+t/CcYk1T5Bhu8QX1czZrAgFpnqPAzBaypnsy0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBf+PN4llfWmKq3ST0kEBrreanXX9zhsqx0DaMsTWbdbS3mDj7LXBg8AS6dhZdcHQIqFEv5LrmxmAtSBvokkw71byAOhnKmW1UwNIfm3LWrb/EDBwH04yIQwVYE8Q8YCvd/ZafSdfCm47k8nczH/kh1JncEEg/XR3BGCvnjVITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYuY8XeO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYuY8XeO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA59C4CED2;
	Thu, 30 Jan 2025 13:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738244156;
	bh=cL2E+t/CcYk1T5Bhu8QX1czZrAgFpnqPAzBaypnsy0g=;
	h=From:To:Cc:Subject:Date:From;
	b=gYuY8XeOrx0d6Au5wfX7OLXTwnZpK97VxBJZcDPanFJj5Spu9aD1VUqKHW2ueA4Q0
	 aZ7JEUhFzB1/xGpmVjZJWkcV/0s+78gFyQmgF4iyQyQ81DZXMQVpOqs9rRZj9+skH/
	 XyqoFAmz8vv2bvaKls/WfoiIA1MSy8m2f10n9pDrREf33fbBeFAEtUCoDZ8Mfb3ArM
	 MFB+3zI2QEE0BmVBy40oypcBCC+rCSBg5Uw2QIpzk6vPG5NIKcxQ8AjxJUV3d80npt
	 5frhVSjzokTQ6p0UuhdVWy1QVlUEWyTkbc4FDPPmq6l6m8FAx3weip283e9JsXxYbI
	 755DfXMQpyztQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>,
	linux-doc@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH 0/1] Add 'external' to the libata.force kernel parameter
Date: Thu, 30 Jan 2025 14:35:45 +0100
Message-ID: <20250130133544.219297-3-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2232; i=cassel@kernel.org; h=from:subject; bh=cL2E+t/CcYk1T5Bhu8QX1czZrAgFpnqPAzBaypnsy0g=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJnNxiwfbtfmcE+5WF0ZFPGhx8rDx7eekn+1Kawbzt+f RAL1Ynw6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEYqoZ/udan5H+cWdGnstS 2dl7jS52bf/45Mvqnu71+b9Dyvp2v/3MyPBdtUxmroOgYZnGfH2u01uUZ05rvW0RFHTqzbQ9Uyb q83IDAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,


This patch replaces an earlier patch proposal, which added an
'external_port_map' kernel module parameter to the ahci driver:
https://lore.kernel.org/linux-ide/20250116143630.1935474-4-cassel@kernel.org/


This patch instead adds support for 'external' to the existing libata.force
kernel parameter.


Normally we do not enable LPM on ports that are marked as external by
firmware. However, as always, firmware can have bugs and can have forgotten
to mark a port as external.

One workaround for such buggy firmware would be to modify the
'mobile_lpm_policy' kernel module parameter, however, that will affect the
LPM policy for all ports.

This patch allows a user to mark one or more ports as hotplug capable (in
case firmware has failed to do so). This way, you will still get LPM (power
saving) on the ports that are not marked as external.


One example where this can be used, is for buggy devices such as the
"HL-DT-ST BD-RE BU40N" Blu-Ray player, which does not reply to a regular
COMRESET (the controller sees nothing as connected), instead it will send
a hotplug event when, and only when the user presses the tray open button.

Not replying to a COMRESET is not spec compliant. If a port does not
detect any device on a port, and LPM is enabled on that port, and the
port is not marked as hotplug capable, then there should be no way that
a device can be hotplugged later, so libata powers off the port/PHY to
save power.

Adding 'external' to libata.force gives users a way to handles such non
spec compliant devices in a more fine grained way (rather than using the
big 'mobile_lpm_policy' hammer).

There does also exist a per port link_power_management_policy sysfs
attribute, however, for many people, using libata.force (which can be
either on the kernel command line, or as a kernel module parameter)
is more convenient compared to writing udev rules.


Kind regards,
Niklas

Niklas Cassel (1):
  ata: libata-core: Add 'external' to the libata.force kernel parameter

 .../admin-guide/kernel-parameters.txt         |  2 +
 drivers/ata/libata-core.c                     | 38 +++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.48.1

