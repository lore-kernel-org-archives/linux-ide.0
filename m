From: Tejun Heo <tj@kernel.org>
Subject: #tj-upstream build fails because system_entering_hibernation is not
 exported
Date: Sun, 05 Oct 2008 05:39:57 +0900
Message-ID: <48E7D49D.4080808@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57137 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbYJDUmE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 16:42:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Rafael.

#tj-upstream fails to build with the following message.

ERROR: "system_entering_hibernation" [drivers/ata/libata.ko] undefined!

Please export it.  Thanks.

-- 
tejun
