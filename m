Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4A1DE3BC
	for <linux-ide@vger.kernel.org>; Thu, 16 Jan 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038200; cv=none; b=ffkiOR3GJdQbHXn4xz6maV4gARD7T7U2ApklAch1tTsXuFP0aiaaNNHQx7g6U6ZN6dw6RUbzhjWn6c3tGzaeeox9nDTkBackO0Y4/fxpA5MvR6f80gTKedCreTrpU+VwPwj7SXzko7v9408p+YqhpL46C7N1f/BuEfZyb0UBNAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038200; c=relaxed/simple;
	bh=rkvW9sCnfjAZxAUXb+dQLJMVFsDw7LyYaK7blekwZrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mY9tL5XJPsB0vcj6Mw82Z0D2HOJF1q/OW/jdaOlorAcL2Fihf08aXfZEjteQPCuQMxyoJNFmH7/vWQs79V4ir8RDWGMkeqxid4VlXIDyl0OLOLpZuUty1TfK2MZsRu8rM/W254+T4UzdFn3MxwQkWGjsbj+uYDqMF0tnkBCxPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMDfjzWx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMDfjzWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91202C4CED6;
	Thu, 16 Jan 2025 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038199;
	bh=rkvW9sCnfjAZxAUXb+dQLJMVFsDw7LyYaK7blekwZrc=;
	h=From:To:Cc:Subject:Date:From;
	b=jMDfjzWxeGbMbwoCYxI45trh28MafBJftDogF+9Bvf2Rp0QARnfZiS5IB5Su5seL4
	 +XjDo/GOe7L2xHYZKfIn4etw10N2AgGL/uf8ifybP5viLZP9wvQwE8gTQMMcVaoHeq
	 O0CvQpvEBJ207JusfIds1g53NONAouUIUet5Kx2RxnSeBcZVXV65jOFBbNZAlrENm1
	 0ESv0brieeV5y4aNcIjMnxOSIB4+/iyQitkYWKXrzlZpjBVzBYf7+AZ15W3HDYvkN5
	 B0S91422PUZSbuOFi1kV+OBZ1xVMLWW553JS7N74U6J+LMdA/YmHA6IWR6JK/L1JuE
	 9IcNvvetdkE0g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>,
	linux-ide@vger.kernel.org
Subject: [PATCH 0/2] Add external_port_map module parameter
Date: Thu, 16 Jan 2025 15:36:31 +0100
Message-ID: <20250116143630.1935474-4-cassel@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=cassel@kernel.org; h=from:subject; bh=rkvW9sCnfjAZxAUXb+dQLJMVFsDw7LyYaK7blekwZrc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI7JfNjq6xTrFi6jy0oveyR8PjXtYYvB9qy8/f5iV19v i3txu39HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIjCrDP6W9JfEn/gd/dLTe vpWbK72kyaZU2ypxjne6cMunGw2TWBj+yhbIP7hsrB0wofG4CPN7DZanqRaaNwwN8tlWtKVYT3/ BAAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

This adds a module parameter 'external_port_map' to the 'ahci' driver.

Normally we do not enable LPM on ports that are marked as external by
firmware. However, as always, firmware can have bugs and can have forgotten
to mark a port as external.

This module parameter gives those users a way to still have their ports
hotplug capable, without modifying the 'mobile_lpm_policy', which will
affect the LPM policy for all ports.

This module parameter allows you to just mark a single port as external,
such that you will still get power saving on the ports that are not marked
as external.


One example where this module parameter can also be used, is for buggy
devices such as the "HL-DT-ST BD-RE BU40N" Blu-Ray player, which does not
reply to a regular COMRESET (the controller sees nothing as connected),
instead it will send a hotplug event when, and only when the user presses
the tray open button.

Not replying to a COMRESET is not spec compliant. If a port does not
detect any device on a port, and LPM is enabled on that port, and the
port is not marked as hotplug capable, then there should be no way that
a device can be hotplugged later, so libata powers off the port/PHY to
save power.

This module parameter will give users a way to handles such non spec
compliant devices in a more fine grained way (rather than using the big
'mobile_lpm_policy' hammer).

There does also exist a per port link_power_management_policy sysfs
attribute, however, for many people, a kernel module is more convenient
compared to writing udev rules.


Kind regards,
Niklas


Niklas Cassel (2):
  ata: ahci: Create a ahci_get_port_map_helper() helper
  ata: ahci: Add external_port_map module parameter

 drivers/ata/ahci.c | 89 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 17 deletions(-)

-- 
2.48.0

