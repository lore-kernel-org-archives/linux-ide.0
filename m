From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Merging libata PATA support into the base kernel
Date: Fri, 11 Aug 2006 00:27:38 +0200
Message-ID: <m3lkpwgrad.fsf@defiant.localdomain>
References: <1155144599.5729.226.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:63114 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751484AbWHJW1l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 18:27:41 -0400
In-Reply-To: <1155144599.5729.226.camel@localhost.localdomain> (Alan Cox's message of "Wed, 09 Aug 2006 18:29:59 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Jeff (rightly) thinks the plan should be discussed publically, so here
> is the plan
>
> For 2.6.19 to move the libata drivers to drivers/ata
> Add a subset of the new PATA drivers living in -mm to the base kernel

Good plan.

> Many of the new libata drivers are already more stable and functional
> than the drivers/ide ones.

Certainly.
-- 
Krzysztof Halasa
