From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] hpt366: add debounce delay to cable_detect() method
Date: Fri, 20 Nov 2009 19:45:37 +0000
Message-ID: <20091120194537.7b4004c2@lxorguk.ukuu.org.uk>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
	<200911202152.22910.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36751 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751986AbZKTToj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2009 14:44:39 -0500
In-Reply-To: <200911202152.22910.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: davem@davemloft.net, linux-ide@vger.kernel.org, stable@kernel.org, bzolnier@gmail.com

On Fri, 20 Nov 2009 22:52:22 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Alan Cox reported that cable detection sometimes works unreliably
> for HPT3xxN and that the issue is fixed by adding debounce delay
> as used by the vendor drivers.
> 
> While at it, get rid of unneeded parens/space in the vicinity...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Cc: stable@kernel.org

Acked-by: Alan Cox <alan@linux.intel.com>
