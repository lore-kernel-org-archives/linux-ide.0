From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Update libata driver for bf548 atapi controller against
 the 2.6.24 tree.
Date: Wed, 17 Oct 2007 20:59:00 -0400
Message-ID: <4716AFD4.4040205@garzik.org>
References: <1192524207.11166.1.camel@sevens.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33993 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388AbXJRA7C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 20:59:02 -0400
In-Reply-To: <1192524207.11166.1.camel@sevens.analog.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Linux IDE <linux-ide@vger.kernel.org>, bzolnier@gmail.com

Sonic Zhang wrote:
> Changes:
> 1. Remove irq_ack() and port_disable() methods
> 2. Acocomodate for the libata-link patches
> 3. Change Kconfig ATAPI mode option into a module param.
> 4. Add supported WMDMA mode.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

applied


