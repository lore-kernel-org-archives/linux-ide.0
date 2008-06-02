From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] ipr: Fix HDIO_GET_IDENTITY oops for SATA devices
Date: Mon, 02 Jun 2008 13:51:18 -0500
Message-ID: <48444126.8050107@linux.vnet.ibm.com>
References: <12124164141515-patch-mail.ibm.com>	 <48441AEE.6050605@garzik.org> <48441F82.6060706@linux.vnet.ibm.com>	 <1212425124.3369.20.camel@localhost.localdomain>	 <4844312C.7010403@garzik.org> <1212429428.3369.45.camel@localhost.localdomain> <484437C3.8020306@garzik.org>
Reply-To: brking@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:47192 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbYFBSvf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 14:51:35 -0400
In-Reply-To: <484437C3.8020306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-scsi@vger.kernel.org, thlin@linux.vnet.ibm.com, linux-ide@vger.kernel.org, miltonm@bga.com, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> The other reason why we use one-short-per-port on master/slave is that, 
> in many respects, each legacy IDE port really can behave like a 
> completely separate controller, each port with its own interrupts and 
> independent reset logic.
> 
> Thus ATA really has two models:  1-port-1-host and N-ports-1-host.

One thing that having a per-port SCSI host buys us is that it isolates
EH to the port rather than the entire SCSI host. The way that the new
libata EH is designed, it can end up spending a fair amount of time
in EH and may even sleep for seconds at a time, waiting for the device
to come ready. Quiescing all devices on a SAS host due to a single
SATA device gets *very* painful. The new libata EH does much more than
just EH. It wakes up for every ATAPI check condition...

Before we can move to a single SCSI host model, we will
have to make some changes regarding how EH is done in libata...

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
