From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
Date: Mon, 16 Nov 2009 10:51:48 +0900
Message-ID: <4B00B034.5010908@kernel.org>
References: <20091113192429.4dfc9c39@infradead.org>	<4AFFB65F.3020201@kernel.org>	<4AFFBB75.7050601@pobox.com>	<20091115094630.1785b5ca@infradead.org>	<4B004328.8060807@kernel.org>	<20091115102334.1396eea6@infradead.org>	<4B0047CB.5080509@kernel.org> <20091115103313.4691924d@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58075 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbZKPBus (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Nov 2009 20:50:48 -0500
In-Reply-To: <20091115103313.4691924d@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

11/16/2009 03:33 AM, Arjan van de Ven wrote:
>> Enabling DIPM means that the drive will be in charge of transitioning
>> the link into powersave modes, so if sampling SStatus is necessary to
>> determine how much time the link spends in powersave mode.
> 
> do we get a link interrupt when the state changes?
> (with ALPM we do.. optionally.. which is where the flag comes in)

It will depend on the controller I suppose but we can always poll.

Thanks.

-- 
tejun
