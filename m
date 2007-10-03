From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 10/10] libata: fix (hopefully) all the remaining problems
 with devices failing setup/identify
Date: Wed, 03 Oct 2007 16:44:30 -0400
Message-ID: <4703FF2E.5080409@garzik.org>
References: <200710022053.l92Kr5Rj021706@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57090 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbXJCUoc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 16:44:32 -0400
In-Reply-To: <200710022053.l92Kr5Rj021706@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

akpm@linux-foundation.org wrote:
> From: Alan <alan@lxorguk.ukuu.org.uk>
> 
> Two fixes in this test patch.  One of them allows old CF cards to refuse
> pio mode setting, and one to wait for the drive to settle after a set
> features changes the speed settings, which is based upon the workarounds
> used by drivers/ide.
> 
> Please test and report back if you have an afflicted system.  This patch
> isn't for merging just testing.
> 
> The CF card fix will still display errors when the card works (got fixes
> for that once I know the cure works) but should then be found/usable.
> 
> Not signed off by anyone, not for merging

applied to libata-dev.git#for-testing, a throwaway branch for things 
like this


