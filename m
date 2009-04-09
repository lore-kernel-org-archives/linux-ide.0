From: Tejun Heo <tj@kernel.org>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 09 Apr 2009 06:45:08 -0700
Message-ID: <49DDFBE4.40702@kernel.org>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>	<49DDEF02.7090004@garzik.org>	<20090409135323.5b2bed4b@lxorguk.ukuu.org.uk>	<49DDF33E.6000102@garzik.org> <20090409141254.283d9f11@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35454 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbZDINpi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 09:45:38 -0400
In-Reply-To: <20090409141254.283d9f11@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> With the attached patch, you can use ->flags for the two new flags, and 
>> you can set those bits in the driver where you set the other 
>> ATA_FLAG_xxx bits.
> 
> Its half way but I realised there is another reason that doesn't work
> (and indeed why the device private flags are asking for trouble)
> 
> What are the locking sematics for ap->flags ?

ap->flags is owned by EH context and only EH can change it.
ap->pflags is for dynamic flags and can be changed under port lock by
anyone but I forgot why I named that pflags instead of dflags.

Thanks.

-- 
tejun
