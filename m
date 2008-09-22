From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 1/1] pata_sil680: convert CONFIG_PPC_MERGE to CONFIG_PPC
Date: Tue, 23 Sep 2008 07:50:37 +1000
Message-ID: <1222120237.12085.48.camel@pasglop>
References: <200809222147.m8MLlXSa031665@imap1.linux-foundation.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38506 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbYIVVx0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Sep 2008 17:53:26 -0400
In-Reply-To: <200809222147.m8MLlXSa031665@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, galak@kernel.crashing.org, alan@lxorguk.ukuu.org.uk, paulus@samba.org

On Mon, 2008-09-22 at 14:47 -0700, akpm@linux-foundation.org wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> 
> Now that arch/ppc is dead CONFIG_PPC_MERGE is always defined for all
> powerpc platforms and we want to get rid of CONFIG_PPC_MERGE use
> CONFIG_PPC instead.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---


