From: Marc Dionne <marc.c.dionne@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_nv: make hardreset return -EAGAIN on
 success
Date: Wed, 23 Apr 2008 06:44:09 -0400
Message-ID: <480F12F9.9050601@gmail.com>
References: <480EA97D.8080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:19695 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYDWKoY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 06:44:24 -0400
Received: from [192.168.111.2] ([24.200.107.105])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JZR00LZEXTZ3Q76@VL-MH-MR002.ip.videotron.ca> for
 linux-ide@vger.kernel.org; Wed, 23 Apr 2008 06:44:23 -0400 (EDT)
In-reply-to: <480EA97D.8080704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Roland Dreier <rdreier@cisco.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> sata_nv hardreset can't classify but was left out while unifying
> follow-up SRST request mechanism[1].  This caused detection failures
> on those controllers.  Fix it.
This works fine for me on CK804.

Thanks,
Marc

Tested-by: Marc Dionne <marc.c.dionne@gmail.com>

