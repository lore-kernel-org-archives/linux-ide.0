From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch 0/9] convert IDE device drivers to driver model
Date: Fri, 4 Feb 2005 03:39:16 +0100 (CET)
Message-ID: <Pine.GSO.4.58.0502040334540.2469@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:40115 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261685AbVBDClb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Feb 2005 21:41:31 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58435 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S102450AbVBDCjY (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Fri, 4 Feb 2005 03:39:24 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

Patches are against ide-dev-2.6 tree.

#1-8 are IDE fixes/changes needed
#9 is the actual conversion

Bartlomiej
