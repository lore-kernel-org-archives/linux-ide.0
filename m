From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/1] drivers/ata/pata_it821x.c: fix warning
Date: Fri, 22 Aug 2008 02:33:43 -0400
Message-ID: <48AE5DC7.6070201@garzik.org>
References: <200808202348.m7KNmqxR005825@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59120 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbYHVGdr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 02:33:47 -0400
In-Reply-To: <200808202348.m7KNmqxR005825@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> drivers/ata/pata_it821x.c: In function 'it821x_port_start':
> drivers/ata/pata_it821x.c:609: warning: 'mtype' may be used uninitialized in this function
> 
> Pretty horrid fix, but so's a warning..
> 
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

applied another patch that solves this...


