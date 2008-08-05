From: Matthew Wilcox <matthew@wil.cx>
Subject: LibATA support for long sectors
Date: Tue,  5 Aug 2008 13:26:45 -0400
Message-ID: <1217957207-23116-1-git-send-email-matthew@wil.cx>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-148-84.d-ip.magma.ca ([64.26.148.84]:33991 "EHLO
	gonzo.int.wil.cx" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755433AbYHERw2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 13:52:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, Matt_Domsch@dell.com

ATA-8 defines two different methods for increasing the length of
sectors.  Long Physical Sectors increase the native sector size
of the disc while pretending to the OS that sectors are still 512 bytes.
Long Logical Sectors increase the length of the reported sector.  This
patch series adds support for both.  It does not add support for
non-power-of-2 sector sizes as they have not been fully specified yet.


