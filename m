From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2 v1] pata_via.c:  support VX855 and future chips
 whose IDE controller use 0x0571.
Date: Thu, 15 Jan 2009 13:40:52 +0000
Message-ID: <20090115134052.0c56c355@lxorguk.ukuu.org.uk>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087EC56B@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39919 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758776AbZAONku (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 08:40:50 -0500
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087EC56B@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, tj@kernel.org, sshtylyov@ru.mvista.com, JosephChan@via.com.tw

> This patch supports VX855 and future chips whose IDE controller use 0x0571.

The patch adds entries for 0xFFFF (is that really right) as a bridge and
0xC409 - I see nothing for 0x0571.

Also all the second port stuff is unneeded: Just do

	if (has_one_port)
		ppi[1] = &ata_dummy_port_info;

and only the first port will be probed.
