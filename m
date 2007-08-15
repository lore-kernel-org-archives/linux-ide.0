From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH take #5] [libata] libata driver for bf548 on chip ATAPI
 controller.
Date: Wed, 15 Aug 2007 11:06:54 +0100
Message-ID: <20070815110654.360cc210@the-village.bc.nu>
References: <1187169256.31383.3.camel@sevens.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39590 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751410AbXHOJ7T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 05:59:19 -0400
In-Reply-To: <1187169256.31383.3.camel@sevens.analog.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Wed, 15 Aug 2007 17:14:15 +0800
Sonic Zhang <sonic.adi@gmail.com> wrote:

> Update:
> 1. Condition branch code instead of while loop from Alan Cox.
> 2. Condtinue in PIO mode after failing to request DMA.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

Acked-by: Alan Cox <alan@redhat.com>


Minor stuff like consts can go in later as a tidy up. Also the big chunk
of work to improve this driver (removing a lot of shared reset/probe
code) needs libata changes and will be easier to do after not before merge
