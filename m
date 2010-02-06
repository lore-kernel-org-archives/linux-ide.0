From: Tejun Heo <tj@kernel.org>
Subject: Re: Corrupt data - RAID sata_sil 3114 chip
Date: Sat, 06 Feb 2010 12:54:08 +0900
Message-ID: <4B6CE7E0.1060209@kernel.org>
References: <4B630914.9010503@fs.ei.tum.de> <4B6338E2.1040507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51777 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab0BFIHY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Feb 2010 03:07:24 -0500
In-Reply-To: <4B6338E2.1040507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "Ulli.Brennenstuhl" <Ulli.Brennenstuhl@fs.ei.tum.de>, linux-ide@vger.kernel.org

Hello,

On 01/30/2010 04:37 AM, Robert Hancock wrote:
> On 01/29/2010 10:13 AM, Ulli.Brennenstuhl wrote:
>> After deactivating every single bios option that somehow optimizes the
>> pci bus the problem seems to be gone. After some more testing I could
>> narrow the problem down to the option "PCI Master 0 WS Write", which
>> controls if requests to the pci bus are executed immediately (with zero
>> wait states) or if every write request will be delayed by one wait state.
>>
>> Obviously this reduces the performance. I didn't perform tests but the
>> resync speed of the raid dropped from ~ 28mb/s to ~ 17mb/s.
>>
>> I hope this also solves the problems for other people and it would be
>> interesting if any change to the driver would allow to reenable the "PCI
>> Master 0 WS Write" option.
> 
> I don't imagine there's anything the driver's likely to be able to do to
> avoid it. That sounds like a definite chipset bug. The PCI interface on
> older VIA chipsets was pretty notorious for them.

Sil3112/3114 are now virtually the only controllers with occassional
and unresolved data corruption issues.  The other one was sata_via
with ATAPI devices which got a possible fix recently (it needed a
delay or flush during command issue or CDB leaked into write buffer).

Given that these sil chips are used very widely and the relatively low
frequency and certain traits like putting two controllers on the bus
triggers the problem more easily and this fiddling with PCI bus option
resolves it, it's conceivable that signal tx/rx quality of sil3112/4
is borderline in certain cases which usually doesn't show up but
causes problem when there also are other weaknesses in the bus (heavy
loading, bus controller not having exactly the best signal quality and
so on.

It would be great if there's some knob we can turn in the controller
PCI config space but I really have no idea whatsoever.  :-(

Thanks.

-- 
tejun
