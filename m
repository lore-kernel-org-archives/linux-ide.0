From: Philip Langdale <philipl@overt.org>
Subject: Enabling MSI in sata_nv
Date: Sun, 02 Dec 2007 19:07:48 -0800
Message-ID: <47537304.2030801@overt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usul.saidi.cx ([204.11.33.34]:57941 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752302AbXLCDzE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 22:55:04 -0500
Received: from c-76-21-109-3.hsd1.ca.comcast.net ([76.21.109.3] helo=[192.168.0.2])
	by usul.overt.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <philipl@overt.org>)
	id 1Iz1Vl-0006ke-Am
	for linux-ide@vger.kernel.org; Sun, 02 Dec 2007 21:58:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

At least for my hardware (MCP55), the sata controller supports MSI
and it seems that turning it on is as simple as inserting the call
to pci_enable_msi - after that it Just Works(tm).

Are there any gotchas that I'm missing? Would a patch to do this
be accepted?

--phil
