From: "Alok kataria" <alokkataria1@gmail.com>
Subject: use_clustering (sht) bit set to 0 in AHCI ?
Date: Thu, 26 Apr 2007 11:19:04 +0530
Message-ID: <35f686220704252249y6d4fe0c3y1a772119c7b6657f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:24544 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743AbXDZFtF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Apr 2007 01:49:05 -0400
Received: by nz-out-0506.google.com with SMTP id o1so590403nzf
        for <linux-ide@vger.kernel.org>; Wed, 25 Apr 2007 22:49:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Hi Jeff,

I recently got a new AHCI disk, and was using the AHCI-libata driver to run
this. I noticed that the scattergather lists that were being built for
the I/O on this device were just of PAGE_SIZE length, even though i
was doing IO on
contiguous pages.

Through a little instrumentation i figured out that the use_clustering
bit in the ahci_sht (scsi_host_template) is set to zero. Due to which
we are not putting consecutive bios into one sg in blk_rq_map_sg.

I tried changing the clustering bit to 1, but encountered a panic at
the initialization of the disks  during the bootup process, and so
couldn't entirely get hold of the panic mesg.
I was wondering, though the max segment size suported with this driver
is 65536, why was i not able to feed in bigger SG's to this driver.

I searched on the net and the intel ahci arch doc too but couldn't
find anything relative to the clustering support for AHCI.

It would be great help if you could let me know about the possible
problems with clustering on AHCI  ? why is it off by default in the
driver ? or anything else that might help.

Thanks & Regards,
Alok Kataria.

Principal Dev. Engg.
Calsoft Pvt. Ltd.
Pune, India.
