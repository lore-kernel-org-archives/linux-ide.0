From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.20 libata cdrom
Date: Tue, 1 May 2007 15:28:20 +0100
Message-ID: <20070501152820.5f6a2eb5@the-village.bc.nu>
References: <20070427175205.GD7809@electro-mechanical.com>
	<4635C35D.1020807@gmail.com>
	<20070430202107.GF5942@electro-mechanical.com>
	<4636C2C7.8090206@gmail.com>
	<20070501121703.GH5942@electro-mechanical.com>
	<46373AEE.6070908@rtr.ca>
	<20070501131818.GA18521@electro-mechanical.com>
	<46374354.7040307@gmail.com>
	<463745E9.2040902@rtr.ca>
	<46374C75.3030006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40347 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423587AbXEAOYq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 10:24:46 -0400
In-Reply-To: <46374C75.3030006@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <lkml@rtr.ca>, Tejun Heo <htejun@gmail.com>, William Thompson <wt@electro-mechanical.com>, Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com

On Tue, 01 May 2007 10:19:33 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Mark Lord wrote:
> >> Gee... Two crazy screwed up devices today.  What's going on?
> > 
> > libata is finally seeing use by non-kernel developers.
> 
> Amusing but factually incorrect.  libata has been shipping in major 
> distros for years, with bazoodles of active users.

But not for PATA devices, SATA is *far* saner ...
