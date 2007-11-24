From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_piix: port enable for the first SATA controller of
 ICH8 is 0xf not 0x3
Date: Fri, 23 Nov 2007 20:22:42 -0500
Message-ID: <47477CE2.5080707@garzik.org>
References: <20071119041459.GA30919@htj.mynetwork.cxm> <20071119041600.GB30919@htj.mynetwork.cxm> <20071119041731.GC30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38305 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797AbXKXBWo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:22:44 -0500
In-Reply-To: <20071119041731.GC30919@htj.mynetwork.cxm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, tr@tng.de

Tejun Heo wrote:
> ICH8 and 9 use two SFF controllers to show 6 SATA ports.  The first
> controllre hosts the first 4 ports while the second one hosts the last
> 2.  The PCS register of the first controller encompasses the first
> four ports or all six ports depending on configuration while PCS of
> the second controller controls the last two ports.  Using 0xf for the
> first controller and 0x3 for the second controller always result in
> the correct configuration.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> applied to #tj-upstream-fixes

ACK


