From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA NCQ
Date: Wed, 02 Feb 2005 14:30:22 -0500
Message-ID: <42012A4E.1020100@pobox.com>
References: <000401c50957$0e9d4600$3805040a@internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38092 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262747AbVBBTag (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Feb 2005 14:30:36 -0500
In-Reply-To: <000401c50957$0e9d4600$3805040a@internal.synopsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mat.Loikkanen@synopsys.com
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mat Loikkanen wrote:
> Jeff-
> 
> Any word on when Native Command Queueing will be supported by Libata?  I see
> in your status report there's a dependency on drives being available.  As it
[snip, due to mailing list]
> implemented over in Windows?) ... I'd be available to work on adding NCQ
> support to Libata, but my unfamiliarity with the SCSI layer's workings may
> be a big hurdle.  What do you think?


(cc'd to linux-ide, for others' information)

Well, you also need a controller that does DMA and NCQ, not just a 
drive.  NCQ is basically a handshaking protocol between the controller 
and drive, letting the drive tell the controller when to DMA <x> sectors 
from outstanding ATA command <y>.

No hard date on NCQ availability, and you are welcome (encouraged!) to 
contribute NCQ support.

Adding NCQ support is
(a) telling the SCSI layer our queue depth
(b) handling more than one command outstanding at a time (libata should 
be mostly ready for this, already)
(c) error handling

(c) is the hardest part.  Getting working NCQ is easy ('a' and 'b'), but 
making sure you recover correctly from errors is the biggest part of the 
task.

That said...   patches are always welcome!

	Jeff


