From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH] sata_via: fix resource-managed iomap conversion
Date: Mon, 12 Feb 2007 20:33:02 +0100
Message-ID: <20070212193302.GA5003@gentoox2.trippelsdorf.de>
References: <20070210010914.GA19717@havoc.gtf.org> <20070210054629.GA4395@gentoox2.trippelsdorf.de> <45CF93D1.9080009@gmail.com> <20070212025843.GA4406@gentoox2.trippelsdorf.de> <45D0B740.9050704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out-43.synserver.de ([217.119.50.43]:37097 "HELO
	smtp-out-43.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965334AbXBLTdN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 14:33:13 -0500
Content-Disposition: inline
In-Reply-To: <45D0B740.9050704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Feb 12, 2007 at 10:51:44AM -0800, Tejun Heo wrote:
> Conversion to resource-managed iomap was buggy causing init failures
> on both vt6420 and 6421 - BAR5 wasn't mapped for both controllers
> while on vt6420 sata_via tried to map BAR0-4 twice.  Fix it.
> 
> DO NOT APPLY YET.
> ---
> Markus, does this fix your problem?

Yes it does. Thank you very much. I appreciate your work.
-- 
Markus
