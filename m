From: Jeff Garzik <jgarzik@pobox.com>
Subject: libata todo item: retry certain classes of errors
Date: Thu, 06 Jan 2005 23:33:28 -0500
Message-ID: <41DE1118.9020209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64149 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261232AbVAGEdf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2005 23:33:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Albert Lee <albertcc@tw.ibm.com>, Andy Warner <andyw@pobox.com>


libata error handling is still of the "stupid simple" variety.  While 
that makes it easy to verify, it also means that we don't always recover 
  from some situations.

Right now, libata simply returns an error back to the SCSI layer.

For DMA, PCI and SATA bus errors, we need to reset the hardware and 
retry the command.

It's a fairly important project, for anyone ambitious.  Error handling 
must be improved before I implement queueing (and possibly hotplug).

	Jeff



