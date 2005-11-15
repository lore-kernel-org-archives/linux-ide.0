From: "SMALL, Timothy" <timothy.small@astrium.eads.net>
Subject: RE: sata_sil24 corruption details
Date: Tue, 15 Nov 2005 09:30:43 -0000
Message-ID: <C2D16922D674664C9CCA61127AC9B77B03E0EE@auk52177.ukr.astrium.corp>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viruswall.astrium.eads.net ([194.203.13.70]:59914 "EHLO
	viruswall.astrium.eads.net") by vger.kernel.org with ESMTP
	id S1751408AbVKOJa7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Nov 2005 04:30:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "'linux@horizon.com'" <linux@horizon.com>, linux-ide@vger.kernel.org
Cc: htejun@gmail.com



> The fact it's the slot furthest from the bridge seems 
> suggestive, but PCIe is packetized with link-level CRCs and 
> retransmission, so transmission problems shouldn't be capable 
> of causing corruption. Might I have a bad bridge chip?
> 
> I'm currently reading the PCIe spec looking for link error 
> logging registers.

This is already (at least partly) implemented in the PCI error reporting
stuff from:

http://bluesmoke.sourceforge.net/

Just to verify this...  The developers don't have many cases of real PCI
errors, so it'd certainly be useful for the bluesmoke/EDAC project if you
could see if this notices your data corruption trouble.

Thanks,

Tim.

This email is for the intended addressee only.
If you have received it in error then you must not use, retain, disseminate or otherwise deal with it.
Please notify the sender by return email.
The views of the author may not necessarily constitute the views of EADS Astrium Limited.
Nothing in this email shall bind EADS Astrium Limited in any contract or obligation.

EADS Astrium Limited, Registered in England and Wales No. 2449259
Registered Office: Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England
