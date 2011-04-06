From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: known working sata_sil24.c setup on powerpc platforms?
Date: Wed, 6 Apr 2011 19:00:08 +0200
Message-ID: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42708 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab1DFRAK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Apr 2011 13:00:10 -0400
Received: by pvg12 with SMTP id 12so616098pvg.19
        for <linux-ide@vger.kernel.org>; Wed, 06 Apr 2011 10:00:09 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux PPC <linuxppc-dev@ozlabs.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>, Jeff Garzik <jeff@garzik.org>

Hello,

after investigating problems with sata_sil24.c on a freescale p2020
soc, I wonder if this driver works on powerpc at all?

Does anyone know of a working setup of sata_sil24 on a big endian
powerpc system?

Regards,
-- 
Leon
