From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 16:35:40 +1100
Message-ID: <1259645740.2076.220.camel@pasglop>
References: <1259561052.2076.73.camel@pasglop>
	 <1259624651.2076.158.camel@pasglop>  <4B1459B5.40504@kernel.org>
	 <1259635420.2076.180.camel@pasglop> <1259644647.2076.204.camel@pasglop>
	 <4B14A809.8000304@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53890 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbZLAFgP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 00:36:15 -0500
In-Reply-To: <4B14A809.8000304@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Tue, 2009-12-01 at 14:22 +0900, Tejun Heo wrote:
> libata-acpi.c does that.  Setting ATA_DFLAG_DETACH device flag and
> scheduling EH will do that.  Please take a look at
> ata_acpi_detach_device() but you must be *sure* that your hot unplug
> notification is completely reliable.

That looks even better than prereset hook actually... I'll have a look

Cheers
Ben.

