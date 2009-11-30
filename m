From: Tejun Heo <tj@kernel.org>
Subject: Re: libata PM question
Date: Mon, 30 Nov 2009 16:26:54 +0900
Message-ID: <4B1373BE.3000709@kernel.org>
References: <1259547765.2076.48.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60048 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753908AbZK3H1C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Nov 2009 02:27:02 -0500
In-Reply-To: <1259547765.2076.48.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Shaohua Li <shaohua.li@intel.com>

(Shaohua Li cc'd)
Hello,

On 11/30/2009 11:22 AM, Benjamin Herrenschmidt wrote:
> One quick nit tho, in libata-eh.c, in ata_eh_handle_port_suspend(), any
> reason why you always call ata_acpi_set_state(ap, PMSG_SUSPEND) rather
> than ata_acpi_set_state(ap, ap->pm_mesg) ?
> 
> Not directly related to my pmac driver but it seems like it would cause
> calls into ACPI suspend/resume code even when doing freeze/thaw for
> hibernation which doesn't sound totally right to me ... or do I miss
> something ?

Indeed, it looks like it will power down the IDE port over freeze.
Shaohua, this is added by commit
bd3adca52bc43b72c75db3e4c7809d47923b154c.  Skipping power down on
freeze is probably the right thing to do?

Thanks.

-- 
tejun
