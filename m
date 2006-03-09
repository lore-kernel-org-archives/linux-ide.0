From: Adrian Bunk <bunk@stusta.de>
Subject: drivers/scsi/sata_vsc.c: inconsistent NULL checking
Date: Thu, 9 Mar 2006 12:02:07 +0100
Message-ID: <20060309110207.GA4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51474 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751813AbWCILCI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Mar 2006 06:02:08 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

The Coverity checker found this inconsistent NULL checking recently 
introduced by the following commit:

  2ae5b30ff08cee422c7f6388a759f7
  Author: Dan Williams <dan.j.williams@intel.com>
  [PATCH] Necessary evil to get sata_vsc to initialize with Intel iq3124h hba


In function vsc_sata_interrupt():

	err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
	vsc_sata_scr_write(ap, SCR_ERROR, err_status);


vsc_sata_scr_write() always dereferences ap
(since SCR_ERROR < SCR_CONTROL).

Checking for NULL in one line and unconditionally dereferencing the 
variable in the next line can't be right.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

