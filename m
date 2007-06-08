From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: claim ctl port for legacy SFF ports
Date: Fri, 8 Jun 2007 13:50:53 +0100
Message-ID: <20070608135053.7022b06e@the-village.bc.nu>
References: <20070604235157.GD31462@havoc.gtf.org>
	<20070608114119.GE29122@htj.dyndns.org>
	<20070608125128.59288dc3@the-village.bc.nu>
	<4669452B.4030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52836 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S936297AbXFHMpq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 08:45:46 -0400
In-Reply-To: <4669452B.4030101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> It was that way to allow legacy SFF code to be used in non-PCI
> environment.  Is it gonna?

Probably best to keep that in the affected driver - we have two drivers
at the moment which know bits about ISA legacy and I'm currently folding
them into one. I don't think they can usefully use the libata-sff PCI/IDE
helper code - not all of it anyway.

