From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 40-wire cable detected when directly connected
Date: Fri, 11 Jan 2008 13:56:30 +0000
Message-ID: <20080111135630.5ca76a30@lxorguk.ukuu.org.uk>
References: <200801101824.04863.Tobias_Mueller@twam.info>
	<4786E82A.7010208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49443 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751964AbYAKN7A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 08:59:00 -0500
In-Reply-To: <4786E82A.7010208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Tobias =?UTF-8?B?TcO8bGxlcg==?= <Tobias_Mueller@twam.info>, linux-ide@vger.kernel.org

> I don't know very well about CF but does it even fill UDMA/33?  What
> does 'dd if=/dev/sdc of=/dev/null bs=1M count=16 iflag=direct' say?  You
> can increase count for more reliable result.

Some CF hardware can manage UDMA33, almost no adapters and cable
convertors can however. I don't know if any of the 40pin CF connectors
are rated for over UDMA33 (but they are 40 wire so that is correct ;))

Alan
