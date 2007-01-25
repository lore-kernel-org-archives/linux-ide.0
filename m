From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: share PIO limits among devices sharing a
 channel
Date: Thu, 25 Jan 2007 14:51:25 +0000
Message-ID: <20070125145125.698d3a08@localhost.localdomain>
References: <20070125112947.GC8606@htj.dyndns.org>
	<20070125123030.3093fb32@localhost.localdomain>
	<45B8BDBC.20609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58271 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965375AbXAYOkO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 09:40:14 -0500
In-Reply-To: <45B8BDBC.20609@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

>     Not really, at least not all drivers.  Namely, hpt366.c (still) doesn't 
> merge 8-bit timings (maybe this is handled in hardware but the datasheets 
> don't tell about it then) -- I need to look at fixing this... Well, it was 

I've never been able to find out - but HPT's own drivers don't seem to do
it under any OS so I assume its ok. The timing stuff should be pretty
much the same for both ide and libata as libata lifted most of the rather
nice ide-timing stuff directly from the old IDE layer.

Alan
