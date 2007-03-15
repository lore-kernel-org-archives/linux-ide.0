From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_inic162x: kill double region requests
Date: Thu, 15 Mar 2007 18:07:00 +0000
Message-ID: <20070315180700.2e19de15@lxorguk.ukuu.org.uk>
References: <20070310205636.GA14704@movealong.org>
	<45F4F483.9080302@gmail.com>
	<20070312220656.GA5457@movealong.org>
	<20070315165942.GC15600@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36994 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422965AbXCOREA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 13:04:00 -0400
In-Reply-To: <20070315165942.GC15600@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Nate Riffe <inkblot@movealong.org>, linux-ide@vger.kernel.org, kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Fri, 16 Mar 2007 01:59:42 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Regions are requested twice during initialization causing the second
> one to fail.  This is regression introduced during iomap conversion.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>


