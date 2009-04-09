From: Tejun Heo <tj@kernel.org>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 09 Apr 2009 07:02:27 -0700
Message-ID: <49DDFFF3.1020601@kernel.org>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>	<49DDEF02.7090004@garzik.org>	<20090409135323.5b2bed4b@lxorguk.ukuu.org.uk>	<49DDF33E.6000102@garzik.org>	<20090409141254.283d9f11@lxorguk.ukuu.org.uk>	<49DDFBE4.40702@kernel.org> <20090409145855.44183fe6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41312 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098AbZDIOCx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 10:02:53 -0400
In-Reply-To: <20090409145855.44183fe6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello,

Alan Cox wrote:
>> ap->flags is owned by EH context and only EH can change it.
>> ap->pflags is for dynamic flags and can be changed under port lock by
>> anyone but I forgot why I named that pflags instead of dflags.
> 
> Ok added comments to that effect to libata.h

Great.

> (I guess you used pflag not dflag as ATA_DFLAG_xx is already used ?)
> and switched to using pflags.

Yeah, right, that was it.  Thanks. :-)

-- 
tejun
