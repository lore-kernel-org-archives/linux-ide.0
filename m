From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sil680: kill bogus reset code
Date: Fri, 16 Nov 2007 16:46:45 +0000
Message-ID: <20071116164645.6e349652@the-village.bc.nu>
References: <200711161744.23918.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53145 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752736AbXKPQxy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 11:53:54 -0500
In-Reply-To: <200711161744.23918.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, 16 Nov 2007 17:44:23 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Since writing to two reserved bits ain't much of a housekeeping, I think it's
> time we get rid of the custom error handler in this driver. ;-)
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This code has been discussed 4 months ago, and is still in the same state. :-|
> The patch is against the Linus' tree

Acked-by: Alan Cox <alan@redhat.com>
