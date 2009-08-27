From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Thu, 27 Aug 2009 09:37:01 +0100
Message-ID: <20090827093701.24598b69@lxorguk.ukuu.org.uk>
References: <200801140019.20668.g.chulkov@jacobs-university.de>
	<20080115025435.1e21b703.akpm@linux-foundation.org>
	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>
	<4794501E.90306@gmail.com>
	<20080121130256.2443d7c1@lxorguk.ukuu.org.uk>
	<47949AA4.9090601@gmail.com>
	<20080121141425.45aa9c61@lxorguk.ukuu.org.uk>
	<4794ACAF.70505@gmail.com>
	<4794AD3F.40309@gmail.com>
	<4A95F212.5060008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59548 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750761AbZH0IgO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Aug 2009 04:36:14 -0400
In-Reply-To: <4A95F212.5060008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

> Nvidia CK804 SATA controllers appear to also explode on reading TF 
> registers after media errors in certain cases. (They tend to either 
> lockup the machine or throw HyperTransport timeout machine check 

You must halt any running DMA activity before reading them. This is true
for pretty much all task file style controllers although the results of
not doing so vary by device somewhat.

