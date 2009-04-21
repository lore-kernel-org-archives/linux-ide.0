From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/6] PalmLD IDE
Date: Tue, 21 Apr 2009 15:38:45 -0400
Message-ID: <49EE20C5.8040803@pobox.com>
References: <200904210205.59971.marek.vasut@gmail.com>	<200904211652.34576.marek.vasut@gmail.com>	<20090421161933.334bc5a2@lxorguk.ukuu.org.uk>	<200904211944.08970.marek.vasut@gmail.com> <20090421203535.081649d9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52649 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754469AbZDUTj0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Apr 2009 15:39:26 -0400
In-Reply-To: <20090421203535.081649d9@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marek Vasut <marek.vasut@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Eric Miao <eric.y.miao@gmail.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
>>> Ok so the ATA bus side ready isn't sufficient for your hardware ?
>> I can retry without the delay, but I'm quite afraid I ran into problems 
>> without it. Btw. I rewrote that driver more than half year ago, so I don't 
>> really recall the details, sorry, I don't want to misinform you here.
> 
> No problem... its not as if it slows down anyone elses hardware.
> 
> Ok looks fine for merging - via the ARM tree seems best ?

ARM tree is fine, as long as there's an Acked-by from a libata person -- 
I nominate you, in this case :)

The version posted on 4/20 seemed fine to me (taking into account the 
ensuing thread, of course).

	Jeff




