From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] sata_mv: Deletion of a few unnecessary checks
Date: Tue, 03 Feb 2015 09:30:42 +0100
Message-ID: <54D08732.4050601@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:59109 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbbBCIbA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Feb 2015 03:31:00 -0500
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Feb 2015 09:12:22 +0100

Another update suggestion was taken into account after a patch was applied
from static source code analysis.

Markus Elfring (2):
  Delete unnecessary checks before the function call "phy_power_off"
  More error handling for phy_power_off() in mv_platform_remove()

 drivers/ata/sata_mv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.2.2

