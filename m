From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-dev-2.6-ncq: rewrite __ata_qc_complete
Date: Mon, 27 Jun 2005 08:30:16 -0400
Message-ID: <42BFF158.9060203@pobox.com>
References: <20050626144110.GD24968@htj.dyndns.org> <42BEE593.7050004@pobox.com> <20050627082709.GO19550@suse.de> <42BFC68E.3020707@tw.ibm.com> <42BFDF66.3010402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:43472 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262110AbVF0Mab (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2005 08:30:31 -0400
In-Reply-To: <42BFDF66.3010402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Ah... I see.  Sorry, I didn't check the ATAPI code (Is any SATA ATAPI 
> device selling in retail shops?  I want one for testing but cannot find 
> one).  I'll remove that removal ;-) and add some comment there to 
> clarify things.  it also means that ATAPI handling of my NCQ helpers is 
> broken


Yep, SATA ATAPI is selling in retail shops now.

	Jeff


