From: "Mat Loikkanen" <Mat.Loikkanen@synopsys.com>
Subject: SATA Plugfest
Date: Tue, 1 Mar 2005 10:06:15 -0800
Message-ID: <00fb01c51e89$5c288780$3805040a@internal.synopsys.com>
Reply-To: <Mat.Loikkanen@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Received: from us01smtp1.synopsys.com ([198.182.44.79]:33497 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S261976AbVCASGS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Mar 2005 13:06:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: 'Jeff Garzik' <jgarzik@pobox.com>

Thought I'd pass along our experience at the SATA Plugfest in Milpitas, CA,
recently.  The Plugfest was a 2 1/2 day event where some companies roamed
with their devices, plugging into host controllers from other companies who
stayed put in their hotel suites.  The days were scheduled with 1-hour time
slots.  As far as I could tell, we were the only Linux based platform at the
show.  I'm running Linux on an ARM Versatile dev board; our host controller
is in an FPGA; the PHY is from ST.  All driver layers except my low-level
driver are from the 2.6.10 kernel.  Most devices were GenII.  Aside from an
unexpected (by my driver) interrupt from some ATAPI ODDs in response to a
soft reset, no software issues were encountered.  Thanks to Jeff and all
others who have contributed to Libata, etc.  

-mat
 
Mat Loikkanen
Synopsys, Inc.


