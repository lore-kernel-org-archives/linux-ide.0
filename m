From: starlight@binnacle.cx
Subject: unexpected downspeed of AHCI controller on Intel
  Seaburg 5400
Date: Tue, 18 Nov 2008 15:22:12 -0500
Message-ID: <6.2.5.6.2.20081118152135.01d2fc70@flumedata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.binnacle.cx ([74.95.187.105]:48582 "EHLO mx.binnacle.cx"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272AbYKRUlg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Nov 2008 15:41:36 -0500
Received: from geileis.binnacle.cx (geileis [172.29.87.12])
	by mx.binnacle.cx (envelope-from <starlight@binnacle.cx>)
	(8.14.1/8.14.1) with ESMTP id mAIKZCYw028150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2008 15:35:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Have a relatively recent HP DL160 G5 that incorporates
the Seaburg 5400 chipset.  Appears the 5400 is a MCM
that includes a 631xESB/632xESB I/O controller.

Running untainted kernel 2.6.27.1.  Latest HP BIOS.

