From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.4.x libata fixes (mostly)
Date: Wed, 23 Feb 2005 15:22:16 -0500
Message-ID: <421CE5F8.2070401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54729 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261558AbVBWUWb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 15:22:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Description reproduced from 2.6 version at 
http://marc.theaimsgroup.com/?l=linux-kernel&m=110918919831955&w=2:

This BK push includes additional hardware support, but that's only
because it's (a) obviously low impact and (b) it was in the queue.

Far more important are:

1) API additions, to fix a severe bug:  advanced drivers such as AHCI
were directly bitbanging --non-existent-- PCI IDE registers, causing an
oops, because of function calls buried deep within libata.

Solution:  add the necessary hooks that should have existed all along,
for this functionality.


2) Fix stomping on active devices, if pci_request_regions() fails.  It
is rather more urgent for libata than other situations, since we must
deal with PCI devices that secretly export ISA device regions (legacy
IDE 0x1f0, 0x170).


3) Fix command queue leak, if SCSI->ATA translation fails.


