From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 14:58:21 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F041DACC8@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr16.intel.com ([192.55.52.70]:63171 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932289AbVHKV6h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 17:58:37 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org


>Tony, others, does this change give you any heartburn?  On
>the 460GX and 870 boxes I have, IDE is a PCI device.

No heartburn for me ... as you say IDE is built into one
of the 870 chips.

I don't know whether any non-Intel chipsets provide legacy IDE.

-Tony
