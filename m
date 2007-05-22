From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Add Seagate STT20000A to DMA blacklist.
Date: Mon, 21 May 2007 20:02:43 -0400
Message-ID: <46523323.20304@garzik.org>
References: <fa.6aGWKqGWP2vDWJvVhFqggIUaWVk@ifi.uio.no> <fa.70JldrzRTUl84Jt2lSquANqNr2Q@ifi.uio.no> <fa.xozW+S/WBbGA8Gv2z3FmAe/XymA@ifi.uio.no> <4651E2AF.2080109@shaw.ca> <20070521183102.GA14537@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46668 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755874AbXEVACr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 May 2007 20:02:47 -0400
In-Reply-To: <20070521183102.GA14537@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Robert Hancock <hancockr@shaw.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org

Dave Jones wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=1044 points out an
> additional hard disk that doesn't handle DMA transfers correctly.
> This patch is the libata variant of the earlier patch to drivers/ide/
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

applied


