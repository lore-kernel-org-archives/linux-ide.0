From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/11v2] ata: replace macro with static inline in
 libata.h
Date: Fri, 15 Feb 2008 22:30:36 +0000
Message-ID: <20080215223036.2111edd5@core>
References: <1203113215.15275.53.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60768 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760655AbYBOWie (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 17:38:34 -0500
In-Reply-To: <1203113215.15275.53.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>

On Fri, 15 Feb 2008 14:06:55 -0800
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> Move to using a static inline which will force the same typechecking
> that min_t/max_t do (in this case, short).  As a bonus, avoid a ton
> of sparse warnings like:
> 
> drivers/ata/pata_ali.c:176:14: warning: symbol '__x' shadows an earlier one
> drivers/ata/pata_ali.c:176:14: originally declared here
> 
> Due to nesting min_t macro inside max_t macro which both use a __x
> identifier internally.

NAK. This is a sparse bug, fix sparse.
