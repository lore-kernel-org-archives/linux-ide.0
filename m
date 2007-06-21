From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [RFT] hpt366: reset DMA state machine on timeouts
Date: Thu, 21 Jun 2007 14:31:07 -0500
Message-ID: <20070621193107.GA8840@austin.ibm.com>
References: <200706212154.47398.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:33816 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbXFUTbL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jun 2007 15:31:11 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5LJWF2P012635
	for <linux-ide@vger.kernel.org>; Thu, 21 Jun 2007 15:32:15 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5LJV7k5429960
	for <linux-ide@vger.kernel.org>; Thu, 21 Jun 2007 15:31:07 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5LJV7n3001846
	for <linux-ide@vger.kernel.org>; Thu, 21 Jun 2007 15:31:07 -0400
Content-Disposition: inline
In-Reply-To: <200706212154.47398.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thu, Jun 21, 2007 at 09:54:47PM +0400, Sergei Shtylyov wrote:
> ---
> Linas, here's what I've come up with -- this should apply against 2.6.21.y.
> Compile-tested only, not for merging.

Thanks,

I'll test tonight. Meanwhile, under spoearate cover, I'll post
the libata debug info.

--linas

