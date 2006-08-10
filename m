From: Jeff Garzik <jeff@garzik.org>
Subject: libata iomap, PATA, etc.
Date: Thu, 10 Aug 2006 07:45:20 -0400
Message-ID: <44DB1C50.6050905@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42716 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161186AbWHJLpX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 07:45:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun,

Since you are poking around in this area, I wanted to remind you of the 
promise-sata-pata branch.

A problem with the current libata API is that probe_ent and related code 
does not easily permit two -vastly different- port technologies (SATA 
and PATA, in this case) to be driven by the same hardware. 
promise-sata-pata branch has not been merged because its solution is 
highly ugly.

A better solution will emerge when... you guessed it...  probe_ent goes 
away, and host_set can be initialized directly.  This allows the LLDD to 
directly configure host_set and associated ata_port structures to its needs.

There are also a few other controllers (SiS, VIA) which have similar 
SATA+PATA configurations to be supported.

	Jeff


