From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream 3/3] libata: implement and use
 ata_port_desc() to report port configuration
Date: Mon, 30 Jul 2007 13:55:27 +0100
Message-ID: <20070730135527.17545933@the-village.bc.nu>
References: <20070730052303.GH22374@htj.dyndns.org>
	<20070730052415.GI22374@htj.dyndns.org>
	<20070730052527.GJ22374@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51497 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754501AbXG3Ms2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jul 2007 08:48:28 -0400
In-Reply-To: <20070730052527.GJ22374@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> SFF init helpers and ata_host_activate() automatically add
> descriptions for addresses and irq respectively, so only LLDs which
> isn't standard SFF need to add custom descriptions.  In many cases,
> such controllers need to report different things anyway.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

I believe this is better than the solution I proposed.


