From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: CONFIG_PM=n compile fix
Date: Tue, 03 Jul 2007 10:16:14 -0400
Message-ID: <468A5A2E.1040701@garzik.org>
References: <20070527030954.GA18974@havoc.gtf.org> <20070603225840.GA25465@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60351 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753721AbXGCOQS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:16:18 -0400
In-Reply-To: <20070603225840.GA25465@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Olof Johansson wrote:
> CONFIG_PM=n compile fix.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> 
> Hi,
> 
> On Sat, May 26, 2007 at 11:09:54PM -0400, Jeff Garzik wrote:
> 
>> This is checked into the 'mv-ahci-pata' branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> Didn't build for me without this change, since I had CONFIG_PM=n.

applied


