From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-dev-2.6: pdc2027x timing register fix for 100MHz
 adapters
Date: Thu, 24 Feb 2005 01:10:35 -0500
Message-ID: <421D6FDB.8080608@pobox.com>
References: <003f01c50905$c8090d10$6401a8c0@tw.ibm.com> <421D6CAC.3020308@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6036 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261852AbVBXGKx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 01:10:53 -0500
In-Reply-To: <421D6CAC.3020308@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> 1. For the 100MHz pdc20268 and pdc20270 adapters, rely on the hardware to set the timing registers.

How does the hardware set the timing registers?

Does it snoop the SET FEATURES - XFER MODE command?

	Jeff


