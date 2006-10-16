From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm -C on SATA always prints "standby"
Date: Mon, 16 Oct 2006 12:06:18 -0400
Message-ID: <4533ADFA.4000703@rtr.ca>
References: <200610161136.04754.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:18704 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1422697AbWJPQGV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Oct 2006 12:06:21 -0400
In-Reply-To: <200610161136.04754.len.brown@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-ide@vger.kernel.org, bltk-discussion@lists.sourceforge.net

> hdparm -C seems to work on the PATA laptops I have,
> but it always returns standby on the SATA laptops I have.
> 
> Is this a known issue?

Yes, due to incomplete implemetation of the HDIO_* ioctls in libata.
Somebody else posted a patch here recently to fix it.
I don't know if Jeff picked it up or not.

Cheers
