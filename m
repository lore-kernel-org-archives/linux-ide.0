From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 14/16] libata-link: update EH to deal with PMP links
Date: Tue, 10 Jul 2007 21:54:41 -0400
Message-ID: <46943861.2000104@garzik.org>
References: <11832843614018-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37789 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754444AbXGKByn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:54:43 -0400
In-Reply-To: <11832843614018-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Update ata_eh_autopsy(), ata_eh_report(),
> ata_eh_revalidate_and_attach() and ata_eh_recover() to deal with PMP
> links.  ata_eh_autopsy() and ata_eh_report() updates are
> straightforward.  They just repeat the same operation over all
> configured links.  The only change to ata_eh_revalidate_and_attach()
> is avoiding calling ->cable_select() on non-host ports.
> 
> ata_eh_recover() update is more complex as it first processes all
> resets and then performs the rest.  This is necessary as thawing with
> some links in unknown state can be dangerous.  ehi->action is cleared
> on successful recovery of a link to avoid repeating recovery due to
> failures in other links.
> 
> ata_eh_recover() iterates over only PMP links if PMP is attached, and,
> on failure, the failing link is returned in @failed_link instead of
> disabling devices directly.  These are to integrate ata_eh_recover()
> into PMP EH later.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK 11-14


