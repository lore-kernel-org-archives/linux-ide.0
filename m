From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI
 driver
Date: Mon, 16 Nov 2009 07:21:14 -0800
Message-ID: <20091116072114.65c6fbc2@infradead.org>
References: <20091113192429.4dfc9c39@infradead.org>
	<4AFFB65F.3020201@kernel.org>
	<4AFFBB75.7050601@pobox.com>
	<20091115094630.1785b5ca@infradead.org>
	<4B004328.8060807@kernel.org>
	<20091115102334.1396eea6@infradead.org>
	<4B0047CB.5080509@kernel.org>
	<20091115103313.4691924d@infradead.org>
	<4B00B034.5010908@kernel.org>
	<20091115180058.55caa36f@infradead.org>
	<4B00B5D0.4010707@kernel.org>
	<20091115215531.23edcf5e@infradead.org>
	<4B00EDAC.4080904@kernel.org>
	<4B0109BC.1020204@pobox.com>
	<20091116064308.741b9a5b@infradead.org>
	<4B0168DB.50109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47736 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbZKPPTe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2009 10:19:34 -0500
In-Reply-To: <4B0168DB.50109@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On Mon, 16 Nov 2009 23:59:39 +0900
Tejun Heo <tj@kernel.org> wrote:

> Arjan van de Ven wrote:
> > is there a hardware way to ask for the link status via a link level
> > thing? I thought the sata_scr_read() was by definition a host thing
> 
> sata_scr_read() will do the right thing given the link parameter
> although it needs to be called from EH context for PMP links.  For
> now, just making the functions take @link param and passing it around
> should do.
> 

I'm sorry it just does not make sense to me anymore.
if this moves to be a link level thing, then the statistics also need
to be kept link level, and thus exported link level, and I don't think
that exists.

if that ever comes into existence it's easy to change the whole thing
at that time (and I'll then change PowerTOP to match). But doing
some half "oh and if you call it on THIS kind of object it'll explode"
does not sound sensible.

I think I'm waaaay out of my league in terms of understanding the
libata structure in the things you are suggesting to be honest, and I
do not feel I understand enough of the subtleties in this area.



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
