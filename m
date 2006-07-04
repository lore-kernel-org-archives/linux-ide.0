From: alan@lxorguk.ukuu.org.uk
Subject: PATA updates (rebased)
Date: Tue, 4 Jul 2006 18:14:36 +0000 (UTC)
Message-ID: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47758 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932306AbWGDSO1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:27 -0400
Date: Maw, 04 Gor 2006 19:01:24 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

PATA updates rebased onto latest tree

Adds full support for Jmicron controllers including the PATA port which means
you can finally install Linux on a system with the CD on a PATA jmicron port.

Turns on per device speed setting


