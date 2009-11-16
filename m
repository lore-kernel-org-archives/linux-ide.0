From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
Date: Tue, 17 Nov 2009 00:40:13 +0900
Message-ID: <4B01725D.3040204@kernel.org>
References: <20091113192429.4dfc9c39@infradead.org>	<4AFFB65F.3020201@kernel.org>	<4AFFBB75.7050601@pobox.com>	<20091115094630.1785b5ca@infradead.org>	<4B004328.8060807@kernel.org>	<20091115102334.1396eea6@infradead.org>	<4B0047CB.5080509@kernel.org>	<20091115103313.4691924d@infradead.org>	<4B00B034.5010908@kernel.org>	<20091115180058.55caa36f@infradead.org>	<4B00B5D0.4010707@kernel.org>	<20091115215531.23edcf5e@infradead.org>	<4B00EDAC.4080904@kernel.org>	<4B0109BC.1020204@pobox.com>	<20091116064308.741b9a5b@infradead.org>	<4B0168DB.50109@kernel.org> <20091116072114.65c6fbc2@infradead.org> <4B017133.3060209@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35157 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbZKPPkj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2009 10:40:39 -0500
In-Reply-To: <4B017133.3060209@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

Tejun Heo wrote:
> Hello, Arjan.
> 
> Arjan van de Ven wrote:
>> I think I'm waaaay out of my league in terms of understanding the
>> libata structure in the things you are suggesting to be honest, and I
>> do not feel I understand enough of the subtleties in this area.
> 
> SCR access is a bit subtle because it requires issuing commands if the
> link is behind PMP and internal commands currently assume EH context.
> This is true for all link functions, so I'm suggesting the stats
> helpers to follow the same convention.  This will also make slave link
> configuration work properly (controllers which present two SATA links
> as master/slave of the same port but still provide access to separate
> SCR registers).  You know, it's a link function, make it take a link
> as all other stuff is designed that way.

Oooh... right, I missed that part about exporting to sysfs.  It won't
show up properly for slave links anyway.  Sorry to keep nagging but
it's quite uncomfortable for me to see the code go in as-is.  ALPM was
one thing as it was host specific feature anyway but this is a clearly
link level thing being implemented at the port layer.  Then again, I
agree there isn't any easy solution at this time.  So, I don't object
to the current implementation.

Argh...........

Thanks.

-- 
tejun
