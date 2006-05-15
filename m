From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105
	interfaces
Date: Mon, 15 May 2006 17:35:51 +0100
Message-ID: <1147710951.26686.76.camel@localhost.localdomain>
References: <20051112165548.GB28987@flint.arm.linux.org.uk>
	 <1131818615.18258.6.camel@localhost.localdomain>
	 <446890F0.3020408@ru.mvista.com>
	 <1147706716.26686.64.camel@localhost.localdomain>
	 <4468A6E2.5060305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9445 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932246AbWEOQXS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 12:23:18 -0400
In-Reply-To: <4468A6E2.5060305@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 20:05 +0400, Sergei Shtylyov wrote:

The chips may be dual channel, none of the users I have access to are
using the second channel ..

>     Ah, that register 0x7E reset? Strangely, W83C55[34]F datasheets don't even 
> mention it. :-/

Its in the errata document for the ones I have. You want "W83C553F-G
Engineering Notice Nov 19 2001"


