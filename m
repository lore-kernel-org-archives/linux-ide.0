From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: HPA patches
Date: Thu, 12 Apr 2007 23:16:15 -0400
Message-ID: <20070413031615.GA21061@athena.road.mcmartin.ca>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk> <20070323112411.f6a8a762.randy.dunlap@oracle.com> <20070323200819.4e734f4f@lxorguk.ukuu.org.uk> <20070323130315.7ed48121.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:52170 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbXDMDR4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Apr 2007 23:17:56 -0400
Content-Disposition: inline
In-Reply-To: <20070323130315.7ed48121.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

On Fri, Mar 23, 2007 at 01:03:15PM -0700, Randy Dunlap wrote:
> > It's 0x40. Its a "command dependant bit" - no useful name.
> 
> dependent.  OK, thanks.
> 

Hi,

Pondering about this, it's ATA_LBA according to the docs, specifying
that the address is an LBA.

Cheers,
	Kyle
