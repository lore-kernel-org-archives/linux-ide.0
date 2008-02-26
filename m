From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata: "I do not think it means, what you think it
 means."
Date: Tue, 26 Feb 2008 20:28:55 +0000
Message-ID: <20080226202855.74c9106a@core>
References: <20080226160508.5d358ab4@core>
	<20080226101303.3e1fb3ff.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38703 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753304AbYBZUjX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 15:39:23 -0500
In-Reply-To: <20080226101303.3e1fb3ff.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Tue, 26 Feb 2008 10:13:03 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 26 Feb 2008 16:05:08 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > When masking mask out the modes that are unsupported not the ones that
> > are supported. This makes life happier. 
> 
> do we want a happier life in 2.6.24.x too?

I think that would be wise ;)
