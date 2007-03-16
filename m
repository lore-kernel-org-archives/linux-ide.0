From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 15:15:08 +0000
Message-ID: <20070316151508.543486ec@lxorguk.ukuu.org.uk>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>
	<45F56800.3040104@rtr.ca>
	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>
	<45F5A523.1080500@rtr.ca>
	<45FA8D7A.3040504@rtr.ca>
	<45FAA35C.2090902@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54116 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751044AbXCPOMI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 10:12:08 -0400
In-Reply-To: <45FAA35C.2090902@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

>     Which requires from the drivers to be able to turn off IDE prefetch (and 
> maybe posting too).  I don't see that in this patch (or are you expecting them 
> to just "snoop' the commands and do it automagically?).

We need to see which drivers have that problem and if its only the odd
one then we can handle it in qc_issue. We've already got controllers that
wrap qc_issue to peek at commands and reject some of them (eg the 8212 in
hardware raid mode)

Alan
