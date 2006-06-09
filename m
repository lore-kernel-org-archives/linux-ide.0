From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] AHCI Command Completion Coalescing(CCC) proposal
Date: Thu, 08 Jun 2006 23:53:04 -0400
Message-ID: <4488F0A0.6070609@pobox.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>	 <44883BAE.7070406@pobox.com> <1149820043.5721.7.camel@forrest26.sh.intel.com> <4488EB4A.4050501@pobox.com> <4488EE69.7050907@gmail.com> <4488EF64.9070602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:30949 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965131AbWFIDxH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2006 23:53:07 -0400
In-Reply-To: <4488EF64.9070602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> If we're gonna do it.  EH needs only a few changes probably during 
> autopsy and report.  Fixing up command issue path and implementing 
> command exclusion (NCQ vs. non-NCQ, sil24 does it in hardware, ahci 
> doesn't) will be a bit complex though.

FWIW:  Promise, Marvell, and ServerWorks can all queue non-NCQ commands.

Oh yeah, ADMA too, IIRC.

	Jeff

