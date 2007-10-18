From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] ide: Fix siimage driver accessing beyond array
	boundary
Date: Thu, 18 Oct 2007 22:16:04 +1000
Message-ID: <1192709764.12879.66.camel@pasglop>
References: <20071018005623.153C7DDEBD@ozlabs.org>
	 <47174B4A.3000006@ru.mvista.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33548 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755952AbXJRMQV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 08:16:21 -0400
In-Reply-To: <47174B4A.3000006@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>


On Thu, 2007-10-18 at 16:02 +0400, Sergei Shtylyov wrote:
> Benjamin Herrenschmidt wrote:
> 
> > The siimage use an incorrect construct to access the other drive
> > of a pair, causing it to access beyond an array boundary on non-0
> > interfaces. This fixes it by using the new ide_get_paired_drive()
> > hepler instead.
> 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
>     Please update the driver version in the driver's heading comment. Otherwise
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

I don't believe much in driver versions in tree... the kernel version is
what matter... Bart, what's your stance there ?

Ben.


