From: Christer Weinigel <christer@weinigel.se>
Subject: Re: [RFC-UGLYPATCH] ata: small optimization in linux/libata.h
Date: Fri, 15 Feb 2008 22:32:50 +0100
Message-ID: <20080215223250.0f229dbe@weinigel.se>
References: <1203016578.2748.69.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:59815 "EHLO
	zoo.weinigel.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbYBOVnl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 16:43:41 -0500
In-Reply-To: <1203016578.2748.69.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

On Thu, 14 Feb 2008 11:16:18 -0800
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> Original:
> 	if (++link - ap->pmp_link < ap->nr_pmp_links)
> Next:
> 	if ((char*)++link - (char *)ap->pmp_link < ap->nr_pmp_links * sizeof(*link)) return link;

Ungh. 

Why not rewrite it as (untested):

    if (++link < ap->pmp_link + ap->nr_pmp_links)

That should be just as efficient and more readable since it
is a simple if (ptr < start + size).

  /Christer

