From: "Winstel, Drew" <DWinstel@Miltope.com>
Subject: RE: PDC20269: Limit on number of controllers?
Date: Fri, 25 Feb 2005 11:06:26 -0600
Message-ID: <66F9227F7417874C8DB3CEB057727417044FAC@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Received: from firewall.miltope.com ([208.12.184.221]:18384 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S262746AbVBYRG3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Feb 2005 12:06:29 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

>   The 2.6.11-rc4 needs .bmdma_stop and .bmdma_status to be defined.
>Attached please find the debug patch with the needed hooks. Thanks.

The patch did not apply cleanly (only the actual pata_promise driver 
would patch) against 2.6.10, so I hand-patched both 2.6.10 and 
2.6.11-rc4-bk9, and both drivers appear to work quite well.

ATAPI appears to be working in rc4 with my SONY DDU-1621 DVD-ROM drive 
and a SUSE 9.2 DVD.  

Is there anything you would like me to test?  I currently have 6 hard 
drives, the aforementioned DVD, and a SATA drive hooked up to the on-
board Silicon Image 3512.  

Thanks,

Drew
