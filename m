From: "Mat Loikkanen" <Mat.Loikkanen@synopsys.com>
Subject: data_xfer too fast? - SATA PIO
Date: Mon, 28 Feb 2005 15:39:35 -0800
Message-ID: <00dc01c51dee$c2cf13a0$3805040a@internal.synopsys.com>
Reply-To: <Mat.Loikkanen@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Received: from us02smtp1.synopsys.com ([198.182.60.75]:28901 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S261822AbVB1Xji convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 18:39:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Jeff Garzik' <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

We've run into the issue of ata_mmio_data_xfer() reading our host
controller's data fifo too fast -- requesting a data word when the fifo was
empty, before the device had sent PIO data (in our observed case somewhere
in the middle of a 512 byte IDENTIFY DEVICE PIO data transfer).  I can't see
any provision in Libata for a case like ours where the processor and bus are
"too fast".  Has anyone run into this issue before?  Any ideas on what we
should do about it?  We can make our host controller to wait-state the bus
... but for how long, what if data never arrives ...  Thanks for any help.

-mat
 
Mat Loikkanen
Synopsys, Inc.

