From: Meelis Roos <mroos@linux.ee>
Subject: new warning in ata_sg_clean
Date: Tue, 20 Mar 2007 08:55:05 +0200 (EET)
Message-ID: <Pine.SOC.4.64.0703200853020.16286@math>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:54973 "EHLO smtp2.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbXCTGzI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Mar 2007 02:55:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

In todays 2.6.21-rc4+git the following news warning has appeared on my 
ppc computer:

  CC [M]  drivers/ata/libata-core.o
drivers/ata/libata-core.c: In function 'ata_sg_clean':
drivers/ata/libata-core.c:3558: warning: unused variable 'dir'

-- 
Meelis Roos (mroos@linux.ee)
