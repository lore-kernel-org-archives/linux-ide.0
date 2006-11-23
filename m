From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel ICH9
Date: Thu, 23 Nov 2006 16:56:08 -0500
Message-ID: <456618F8.5070000@pobox.com>
References: <1164149498.27730.17.camel@localhost.localdomain> <1164186260.31358.717.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50617 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S933938AbWKWV4U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Nov 2006 16:56:20 -0500
In-Reply-To: <1164186260.31358.717.camel@laptopd505.fenrus.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jason Gaston <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-11-21 at 14:51 -0800, Jason Gaston wrote:
>> This patch adds the Intel ICH9 AHCI controller DID's for SATA support.
>>
>> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> there was some discussion about a generic class match for ahci...
> would these devices be matched by that?

AHCI class yes, RAID class no.

But vendors would probably /love/ that we didn't match the RAID class, 
even though we can drive it...

	Jeff



