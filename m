From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [git patches] libata fixes
Date: Wed, 27 Jun 2007 00:38:41 -0700
Message-ID: <20070627003841.68fd0ea9.akpm@linux-foundation.org>
References: <20070627073526.GA18787@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44790 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751999AbXF0Hiv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jun 2007 03:38:51 -0400
In-Reply-To: <20070627073526.GA18787@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, 27 Jun 2007 03:35:26 -0400 Jeff Garzik <jeff@garzik.org> wrote:

> +	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
> +	 * few ATAPI devices choke on such DMA requests.
> +	 */
> +	if (unlikely(qc->nbytes & 15))
> +		return 1;

It might be worth emitting a diagnostic when this happens.
