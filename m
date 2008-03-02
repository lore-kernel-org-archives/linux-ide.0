From: Adrian Bunk <bunk@kernel.org>
Subject: ide_register_hw(): buggy code
Date: Sun, 2 Mar 2008 17:19:24 +0200
Message-ID: <20080302151924.GJ25835@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:60053 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbYCBPUy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Mar 2008 10:20:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

The Coverity checker spotted the following bogus change to 
ide_register_hw() in commit 9e016a719209d95338e314b46c3012cc7feaaeec:

<--  snip  -->

...
+               hwif = ide_deprecated_find_port(hw->io_ports[IDE_DATA_OFFSET]);
+               index = hwif->index;
+               if (hwif)
+                       goto found;
                for (index = 0; index < MAX_HWIFS; index++)
...

<--  snip  -->

It's impossible to reach the for() loop without Oopsing before.

Can you either fix this for 2.6.25 or push your patch that removes 
ide_register_hw() for 2.6.25?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

