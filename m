From: "Andrew Chew" <achew@nvidia.com>
Subject: libata-core, 2.4.27-rc3, and scsi_unregister_module()
Date: Mon, 2 Aug 2004 16:42:18 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F9612@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate00.nvidia.com ([216.228.112.144]:52740 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S264522AbUHBXmV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Aug 2004 19:42:21 -0400
Content-class: urn:content-classes:message
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

I noticed that in ata_pci_remove_one, that scsi_unregister_module() is
being called for the SCSI host template.  I also noticed that the SATA
drivers are calling scsi_unregister_module() in their cleanup routines
as well.  Is this work-in-progress, or an actual bug?  In any case, the
scsi_unregister_module() call in ata_pci_remove_one() takes an exception
with a NULL sht upon driver unload (when I'm experimenting with the
sata_nv module).  Commenting out the scsi_unregister_module() call in
ata_pci_remove_one() fixes things.
