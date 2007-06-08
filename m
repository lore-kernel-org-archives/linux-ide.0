From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: claim ctl port for legacy SFF ports
Date: Fri, 8 Jun 2007 12:51:28 +0100
Message-ID: <20070608125128.59288dc3@the-village.bc.nu>
References: <20070604235157.GD31462@havoc.gtf.org>
	<20070608114119.GE29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55190 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S967976AbXFHLqO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 07:46:14 -0400
In-Reply-To: <20070608114119.GE29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Fri, 8 Jun 2007 20:41:19 +0900
Tejun Heo <htejun@gmail.com> wrote:

> libata used to claim only cmd ports for legacy SFF ports.  Claim ctl
> ports too.

Just use pci resource functions. The quirk handlers do the rest for you
already.

