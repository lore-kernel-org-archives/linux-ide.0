From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs.
 intr race fix
Date: Mon, 22 Aug 2005 00:01:55 -0400
Message-ID: <43094E33.3040705@pobox.com>
References: <20050820091651.486821E0@htj.dyndns.org> <4308DA57.9000303@pobox.com> <4308E13E.6070104@gmail.com> <4308E2C9.6040605@pobox.com> <4308E6B1.6030001@gmail.com> <4308F114.9020608@pobox.com> <4308F450.4050402@gmail.com> <4308F943.9090706@pobox.com> <20050821235149.GA14097@htj.dyndns.org> <43091BFA.2020101@pobox.com> <20050822035753.GA28721@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:1678 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751383AbVHVWzV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:55:21 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M45GPK006763
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 21:05:16 -0700
In-Reply-To: <20050822035753.GA28721@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>>(b) [a 'todo' item'] at that point in the HSM, there may actually be an 
>>expected interrupt, before which the CDB should not be sent, per 
>>ATA/ATAPI-4

>  This is deprecated since ATA/ATAPI-4.  Will we see this on SATA ATAPI
> devices?  Maybe for PATA ATAPI's?

Early PATA, though maybe it carried through ATA-6 or so.  For generic 
ATAPI HSM, we need to handle it if a "I have a CDB interrupt" flag is 
set somewhere.

	Jeff


