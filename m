From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Fri, 03 Sep 2010 11:04:52 +0200
Message-ID: <4C80BA34.7090400@kernel.org>
References: <1283027290.2721.37.camel@myfedorahat>	<4C7BAA42.2050809@kernel.org>	<AANLkTimEQEAF7WfCmmSfS_Ryq7HEfqemAnh9BvdKRhqL@mail.gmail.com>	<AANLkTi=3BVGUSNUZn=QbDciWdhBPmxe0kQgKcBFtkSH7@mail.gmail.com>	<AANLkTin5uTJA0G+hWxfsGFhyC_N9ZR7rZN9qCjK5VyvU@mail.gmail.com>	<AANLkTi=mGaNoutyh=iVrGORYjRx_qvnVfMHL63TuY5gY@mail.gmail.com>	<AANLkTikqxmzQozCOo+7XDSWE4tTniSnYbomEgqA4aB-2@mail.gmail.com>	<4C7F77C4.6040404@kernel.org> <AANLkTi=_fmtNjj=ZeSyuMtQg+YBJ3=gHAkeurJhDZmmh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59195 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab0ICJEz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Sep 2010 05:04:55 -0400
In-Reply-To: <AANLkTi=_fmtNjj=ZeSyuMtQg+YBJ3=gHAkeurJhDZmmh@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Siddhartha Jain <siddhartha@siddharthajain.net>
Cc: linux-ide@vger.kernel.org

Hello,

On 09/02/2010 09:56 PM, Siddhartha Jain wrote:
> Applied patch to 2.6.35.4. Patched cleanly and kernel compile was smooth.
> 
> Suspend works beautifully now. Not only does the system resume
> properly but earlier suspend would take minutes, now it goes to
> suspend within seconds (less than 10).
> 
> I will re-build my laptop with dmcrypt + ext4, apply this patch and
> use the system for a while to ensure all play together nicely.
> 
> Thanks Tejun!! Really appreciate the quick turnaround on this issue. I
> saved debugging info from the successful resume where I have debugging
> turned on for various modules - acpi, pci etc. Let me know if you need
> me to send it across.

Debugging was mostly done by Rafael, so he deserves most of credit.
Can you please keep testing for a few more days and let me know the
result?

Thanks.

-- 
tejun
