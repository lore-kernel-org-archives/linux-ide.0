From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 05 Jan 2009 15:44:19 +0300
Message-ID: <496200A3.2000906@ru.mvista.com>
References: <49615667.9020408@iwl.com> <yq1vdsu317m.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56525 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751345AbZAEMo0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2009 07:44:26 -0500
In-Reply-To: <yq1vdsu317m.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com

Hello.

Martin K. Petersen wrote:

>>>>>> "Karl" == Karl Auerbach <karl@iwl.com> writes:
>>>>>>             
>
> Karl> 2. The cs5535 ide driver doesn't seem to be able to recognize the
> Karl> newer CS5536 controller for IDE.
>
> The IDE interface of the Geode CS5536 companion chip is a completely
> different beast.  It's a more or less standard AMD 8111 PCI IDE device
> with slightly different timings.

   I'm not sure I uderstand the passage about "slightly different 
timings"...

> There's a dedicated driver called pata_cs5536.c (CONFIG_PATA_CS5536).
>   

   I must note thst using libata for driving (presumably PIO only) CF 
seems an overkill (if not a slowdown).

> The driver was developed on a Soekris net5501.  To my knowledge it's
> working fine on ALIX boards.  If that's not the case there may be a
> problem with the ALIX BIOS VSA PCI config space emulation.  In that case
> you can load the driver with msr=1 to force it to program the IDE
> function using machine specific registers instead of relying on PCI.
>   

   It's stange that the driver is using CPI config. space by default 
which not even documented in the datasheet. I guess the MSR accesses are 
also somewhat faster because one doesn't have to access the address/data 
register pair at ports 0xcf8/0xcfc...

MBR, Sergei


