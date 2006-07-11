From: Brad Campbell <brad@wasp.net.au>
Subject: Re: PATCH: Fixes for PIIX driver
Date: Tue, 11 Jul 2006 18:37:01 +0400
Message-ID: <44B3B78D.50809@wasp.net.au>
References: <1152550469.27368.150.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:49131 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1750851AbWGKOhC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jul 2006 10:37:02 -0400
In-Reply-To: <1152550469.27368.150.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> A couple of cases were mishandled by the PIIX driver because of wrong
> entries in tables. This caused some ICH chips to select UDMA33 not the
> correct higher UDMA speed. It could also cause the original ICH to
> select a mode the controller didn't support and then fail on boot. 
> 

Works for me, and 2.6.18-rc1-mm1 + this patch is the 1st setup that enables fully functioning s2ram 
on my Sony Vaio VGN-TX27GP. (In fact, a vanilla 2.6.18-rc1 + the libata patches from -mm + this 
patch works a treat).

Ta! :)
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
