From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_via: fix resource-managed iomap conversion
Date: Tue, 20 Feb 2007 11:03:39 -0500
Message-ID: <45DB1BDB.3070901@garzik.org>
References: <20070210010914.GA19717@havoc.gtf.org> <20070210054629.GA4395@gentoox2.trippelsdorf.de> <45CF93D1.9080009@gmail.com> <20070212025843.GA4406@gentoox2.trippelsdorf.de> <45D0B740.9050704@gmail.com> <20070220110153.GO1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44237 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965256AbXBTQDn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 11:03:43 -0500
In-Reply-To: <20070220110153.GO1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> Conversion to resource-managed iomap was buggy causing init failures
> on both vt6420 and 6421 - BAR5 wasn't mapped for both controllers
> while on vt6420 sata_via tried to map BAR0-4 twice.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> I thought I have a vt6421 but mine too was a vt6420.  So, the patch is
> verified only for vt6420 but, the vt6421 path is pretty obvious and
> should be correct.  Please apply.

applied


