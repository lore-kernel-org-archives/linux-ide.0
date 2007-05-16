From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [2/3] 2.6.22-rc1: known regressions v2
Date: Wed, 16 May 2007 13:33:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705161333140.11079@schroedinger.engr.sgi.com>
References: <464B6743.9000607@googlemail.com> <464B6A2B.9020703@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:43109 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758281AbXEPUdt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 16:33:49 -0400
In-Reply-To: <464B6A2B.9020703@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, xfs-masters@oss.sgi.com, David Chinner <dgc@sgi.com>, Jeremy Fitzhardinge <jeremy@goop.org>, "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Dave Airlie <airlied@linux.ie>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Oleg Nesterov <oleg@tv-sign.ru>, Alex Dubov <oakad@yahoo.com>, Pierre Ossman <drzeus@drzeus.cx>

On Wed, 16 May 2007, Michal Piotrowski wrote:

> Memory management
> 
> Subject    : kernel BUG at include/linux/slub_def.h:88 kmalloc_index()
> References : http://bugzilla.kernel.org/show_bug.cgi?id=8476
> Submitter  : Cherwin R. Nooitmeer <cherwin@gmail.com>
> Status     : Unknown


This a kmalloc(0) that needs fixing.
