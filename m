From: linux@horizon.com
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
Date: 1 Sep 2005 16:19:31 -0400
Message-ID: <20050901201931.32178.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:41530 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030354AbVIAUTe
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Sep 2005 16:19:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hch@infradead.org, linux-ide@vger.kernel.org, russb@emc.com

>> +static inline void writelfl(unsigned long data, void __iomem *addr)
>> +{
>> +	writel(data, addr);
>> +	(void) readl(addr);	/* flush */
>
> no need for the (void) case.

Not strictly necessary, but a redundant (void) cast is a pretty standard
way of documenting "yes, I really mean to ignore the return value."

I'd like to suggest that it's helpful to the reader and should stay.
(Maybe even, for those who don't know, change the comment to
"Standard PCI flush trick.")

On your other style comments, I agree.

Well, except that "braces" are {}, while () are "parentheses" or "parens".
