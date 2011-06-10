From: Tejun Heo <tj@kernel.org>
Subject: Added advisement against marvell ATA controller in the ATA wiki page
Date: Fri, 10 Jun 2011 09:00:30 +0200
Message-ID: <20110610070030.GB15235@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32805 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab1FJHAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2011 03:00:35 -0400
Received: by fxm17 with SMTP id 17so1438423fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2011 00:00:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, mlord@pobox.com
Cc: Saeed Bishara <saeed@marvell.com>, Hubert Bailey <hbailey@marvell.com>

Hello, guys.

We've been seeing a lot of problems regarding marvell ATA controller
support.  The blame definitely is shared between marvell and libata
developers, but I don't know what to do anymore.

Regrettably, I don't have the time or energy to hunt down chipsets and
documentation myself and no one else, including marvell, seems
interested in it either.  So, I've added general advisement against
marvell ATA chipsets in the ATA wiki page and will continue to advise
against marvell chipsets.

 https://ata.wiki.kernel.org/index.php/Hardware,_driver_status#Problematic_chipsets

If anyone has _any_ better idea, please share.  As it currently
stands, marvell controllers are the only problematic ones in ATA land
and it would be AWESOME to see it somehow resolved.

Thank you very much.

-- 
tejun
