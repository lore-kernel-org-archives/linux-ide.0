From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.22-rc3 hibernate(?) disables SMART on ide
Date: Sat, 02 Jun 2007 18:18:28 -0400
Message-ID: <4661ECB4.7020902@garzik.org>
References: <8rnax-6XX-11@gated-at.bofh.it> <8rA7H-1B4-1@gated-at.bofh.it> <E1Hub8O-0000rF-Hb@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34588 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757767AbXFBWSg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Jun 2007 18:18:36 -0400
In-Reply-To: <E1Hub8O-0000rF-Hb@be1.lrz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7eggert@gmx.de
Cc: Tejun Heo <htejun@gmail.com>, David Greaves <david@dgreaves.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, IDE Linux <linux-ide@vger.kernel.org>, ballen@gravity.phys.uwm.edu

Bodo Eggert wrote:
> Therefore I suggest setting the smart-enabled-bit in the kernel, in spite of
> not being the kernel's duty. It would be a 99,99% DTRT.

NAK.  That's hardcoding policy in the kernel.

	Jeff


