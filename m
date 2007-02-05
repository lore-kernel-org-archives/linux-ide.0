From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] (2.6.20) pata_mpiix: probing cleanup
Date: Mon, 5 Feb 2007 19:05:21 +0000
Message-ID: <20070205190521.5c91ccbf@localhost.localdomain>
References: <200702052057.24688.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38598 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933337AbXBESyr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 13:54:47 -0500
In-Reply-To: <200702052057.24688.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 5 Feb 2007 20:57:24 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> MPIIX has only single channel IDE which can be configured for either primary or
> secondary legacy I/O ports and IRQ.  So, get rid of the unneeded second probe

Acked-by: Alan Cox <alan@redhat.com>

Nice cleanup
