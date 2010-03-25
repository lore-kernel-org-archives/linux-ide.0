From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] ata/core: don't enable the interrupt while activating the
 host
Date: Fri, 26 Mar 2010 08:54:54 +0900
Message-ID: <4BABF7CE.6060908@kernel.org>
References: <20100311220417.GA16022@Chamillionaire.breakpoint.cc> <4BAAAEA1.9040906@kernel.org> <20100325220421.GA1051@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46733 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab0CYXvy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2010 19:51:54 -0400
In-Reply-To: <20100325220421.GA1051@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-ide@vger.kernel.org

Hello,

On 03/26/2010 07:04 AM, Sebastian Andrzej Siewior wrote:
>> Can you please play with ata_sff_freeze() and find out why it's not
>> working?
> I've been there. I've moved the functions around and nothing changed.
> After removing the ATA_NIEN bit it started working. So it looks like
> ->sff_check_status() & ->sff_irq_clear() are not clearing the interrupt
> for what reason ever.

What happens if you remove everything else from the function and just
set ATA_NIEN?

Thanks.

-- 
tejun
