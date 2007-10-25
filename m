From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-core: Don't have screaming fits over DF/ERR combinations
Date: Thu, 25 Oct 2007 02:04:20 -0400
Message-ID: <472031E4.3050701@pobox.com>
References: <20071015192313.5892ed42@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55719 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbXJYGEZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 02:04:25 -0400
In-Reply-To: <20071015192313.5892ed42@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> Some hardware seems to get this wrong in a non-harmful way, and there are
> some devices that seem to do it deliberately for various reasons.
> 
> Just take it as a device error not a catastrophic state machine
> explosion. 
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied to #for-testing branch, let me know when you think its suitable 
for upstream


