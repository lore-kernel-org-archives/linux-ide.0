From: Guillaume Betous <guillaume@betous.fr.st>
Subject: pdc202xx_old and CONFIG_PDC202XX_FORCE
Date: Sun, 28 Aug 2005 15:19:23 +0200
Message-ID: <4311B9DB.2090306@betous.fr.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pepelepew.homelinux.net ([217.66.125.214]:30257 "EHLO
	pepelepew.homelinux.net") by vger.kernel.org with ESMTP
	id S1750728AbVH1NUc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Aug 2005 09:20:32 -0400
Received: from [192.168.0.2] (pepelepew [192.168.0.2])
	by pepelepew.homelinux.net (Postfix) with ESMTP id 2458D71643
	for <linux-ide@vger.kernel.org>; Sun, 28 Aug 2005 15:19:17 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all !

First, I hope to be in the right mailing-list. Please, tell me if I'm wrong.

I had some minor problems to find my hard drives on the PDC20267 of my 
mother board (Intel SBC2). All the drives were hidden by the BIOS.

I just took a look at the module code and the Kconfig file, and found a 
'FIXME' remark [1]. As it was just around my problem, I took a few hours 
(-; to improve the code, implementing a new configuration bit : 
CONFIG_PDC202XX_FORCE_OLD.

It is exactly the same behaviour of the CONFIG_PDC202XX_FORCE bit, but 
only for the pdc202xx_old module. I changed de Kconfig file too to 
manage separately the two bits.

If you're interested in my changes, I can send patches (as soon as I 
know how to make the patches (((-: )

Regards,

gUI

[1] # FIXME - probably wants to be one for old and for new
