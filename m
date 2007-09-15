From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Fw: Spurious completions during NCQ
Date: Sat, 15 Sep 2007 19:57:13 -0400
Message-ID: <46EC7159.6000904@garzik.org>
References: <20070915005751.353d0c69.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55073 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283AbXIOX5S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Sep 2007 19:57:18 -0400
In-Reply-To: <20070915005751.353d0c69.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Sumanth J.V" <sumanth@cse.unl.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

Andrew Morton wrote:
> 
> Begin forwarded message:
> 
> Date: Fri, 07 Sep 2007 12:57:14 -0500
> From: "Sumanth J.V" <sumanth@cse.unl.edu>
> To: linux-kernel@vger.kernel.org
> Subject: Spurious completions during NCQ
> 
> 
> I keep seeing this message a few times a day on my box.
> 
> ata1.00: exception Emask 0x2 SAct 0x18 SErr 0x0 action 0x2 frozen
> ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x18 
> FIS=004040a1:00000004)
> ata1.00: cmd 60/08:18:bf:04:df/00:00:23:00:00/40 tag 3 cdb 0x0 data 4096 in
>          res 40/00:24:c7:04:df/00:00:23:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/78:20:c7:04:df/00:00:23:00:00/40 tag 4 cdb 0x0 data 61440 in
>          res 40/00:24:c7:04:df/00:00:23:00:00/40 Emask 0x2 (HSM violation)
> ata1: soft resetting port
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> 
> 
> 
> Can I assume that my data integrity is not compromised? Any idea what is 
> happening to the pending writes during the soft reset? How can I verify 
> that all the pending writes were committed?
> 
> I have attached the output of my dmesg, lspci, sdparm and mdadm. Do let 
> me know if you need any other info?


If the error handler can detect the condition (it did), then there is no 
data integrity problem.  We just "down-shift".

	Jeff


