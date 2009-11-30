From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: libata PM question
Date: Mon, 30 Nov 2009 15:32:23 +0800
Message-ID: <1259566343.14613.0.camel@sli10-desk.sh.intel.com>
References: <1259547765.2076.48.camel@pasglop> <4B1373BE.3000709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23147 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786AbZK3HcS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Nov 2009 02:32:18 -0500
In-Reply-To: <4B1373BE.3000709@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Mon, 2009-11-30 at 15:26 +0800, Tejun Heo wrote:
> (Shaohua Li cc'd)
> Hello,
> 
> On 11/30/2009 11:22 AM, Benjamin Herrenschmidt wrote:
> > One quick nit tho, in libata-eh.c, in ata_eh_handle_port_suspend(), any
> > reason why you always call ata_acpi_set_state(ap, PMSG_SUSPEND) rather
> > than ata_acpi_set_state(ap, ap->pm_mesg) ?
> > 
> > Not directly related to my pmac driver but it seems like it would cause
> > calls into ACPI suspend/resume code even when doing freeze/thaw for
> > hibernation which doesn't sound totally right to me ... or do I miss
> > something ?
> 
> Indeed, it looks like it will power down the IDE port over freeze.
> Shaohua, this is added by commit
> bd3adca52bc43b72c75db3e4c7809d47923b154c.  Skipping power down on
> freeze is probably the right thing to do?
yes, looks reasonable though spec doesn't mention such case.

Thanks,
Shaohua


