From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream] pata_jmicron: match vendor and class code
 only
Date: Sat, 6 Oct 2007 23:46:19 +0100
Message-ID: <20071006234619.0b42075f@the-village.bc.nu>
References: <20071006220450.GD12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41123 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762915AbXJFWoP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Oct 2007 18:44:15 -0400
In-Reply-To: <20071006220450.GD12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, ethanhsiao@jmicron.com, justin@jmicron.com

On Sun, 7 Oct 2007 07:04:50 +0900
Tejun Heo <htejun@gmail.com> wrote:

> PATA part of all current JMB controllers behave the same way and
> JMicron confirms that all future ones will stay compatible.  Drop
> device matching and match only vendor and class.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Ethan Hsiao <ethanhsiao@jmicron.com>
> Cc: Justin Tsai <justin@jmicron.com>

Acked-by: Alan Cox <alan@redhat.com>

Tho if I was Jmicron I'd specifc ids 0x0XXX or similar to be safe, but
hey its not my product 8)
