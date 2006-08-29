From: Tejun Heo <htejun@gmail.com>
Subject: Re: Some questions about new EH in libata
Date: Wed, 30 Aug 2006 01:00:26 +0900
Message-ID: <44F4649A.80405@gmail.com>
References: <8202f4270608212154k787f63a1k15ed3dcfff0624c2@mail.gmail.com>	 <44EA91A8.5090309@gmail.com>	 <8202f4270608281751v7cddfdddo28ba1b86eb43e60f@mail.gmail.com>	 <44F3A384.4080505@gmail.com> <8202f4270608290851u20ec2eb5j2fd7e509f617cf35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:28996 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750761AbWH2QBW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 12:01:22 -0400
Received: by ug-out-1314.google.com with SMTP id m3so2023588ugc
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2006 09:01:21 -0700 (PDT)
In-Reply-To: <8202f4270608290851u20ec2eb5j2fd7e509f617cf35@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Fajun Chen wrote:
> I assume that alt status register will be updated when pata/sata is
> back online. So as an alternative and less invasive way, could I check
> alt status register and start user scan only if device is ready on alt
> status register? libata has ata_altstatus() function, is it available
> to user space? If not, may I expose it? I'm looking for a way to check
> device registers without side effects.

You can't use alt status that way.  Not all controllers have them and 
even those which do show different behaviors over hotplug/unplugs.

Hmmm... maybe making userscan synchronous is the correct way to do it. 
I'll give it some thoughts.

-- 
tejun
