From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Sat, 1 Nov 2008 17:45:45 +0100
Message-ID: <20081101164545.GB10321@nuty>
References: <20081101160930.GA10321@nuty> <1225555965-27557-1-git-send-email-n0-1@freewrt.org> <490C833A.7010702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:32784 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbYKAQof (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Nov 2008 12:44:35 -0400
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id C8944386DBBE
	for <linux-ide@vger.kernel.org>; Sat,  1 Nov 2008 17:44:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <490C833A.7010702@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

On Sat, Nov 01, 2008 at 07:26:34PM +0300, Sergei Shtylyov wrote:
>   So, I didn't get what was wrong with using readsl() and writesl()?
>   Besides, using readl() and witel() this way would be wrong on BE mode 
> since the data is expected to be stored to memory in the LE order.

Sorry, my fault. When having a glance at the macro definition, I messed
up the parameter's meanings and assumed the target address would be
incremented, which is normally the case when writing regular memory, not
to IO addresses.

I changed (and successfully tested) the code, patch follows.

Thanks again, Phil
