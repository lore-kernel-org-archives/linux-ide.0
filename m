From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA/ADMA TIMEOUTS, dmesg output
Date: Sat, 30 Jun 2007 16:06:37 -0400
Message-ID: <4686B7CD.2020404@garzik.org>
References: <4686A32F.1010700@widomaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38002 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbXF3UGk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Jun 2007 16:06:40 -0400
In-Reply-To: <4686A32F.1010700@widomaker.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Charles Shannon Hendrix <shannon@widomaker.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Charles Shannon Hendrix wrote:
> 
> 
> Following this post is output from Linux kernel 2.6.21 showing ADMA 
> timeouts.
> 
> 2.6.21 has improved the situation over earlier kernels, but the problems 
> do still occur.
> 
> nforce4 chipset, Seagate Barracuda SATA drives.
> 
> This is meant mainly as an additional data point in case it helps 
> someone debug the problem.

Does setting 'adma' module option to zero fix things?

	Jeff



