From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sil3124: IRQ loss errata on PCI-X
Date: Tue, 14 Aug 2007 19:12:27 +0900
Message-ID: <46C1800B.9030903@gmail.com>
References: <8202f4270708131253o506ec8ffqb97ee9d6e6557816@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:12801 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988AbXHNKMd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 06:12:33 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1398533rvb
        for <linux-ide@vger.kernel.org>; Tue, 14 Aug 2007 03:12:32 -0700 (PDT)
In-Reply-To: <8202f4270708131253o506ec8ffqb97ee9d6e6557816@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Fajun Chen wrote:
> Hi,
> 
> In sata_sil24.c, there's a special flag as shown below:
> 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
> Could someone explain the error condition and the rational behind the fix?

It's a workaround for an erratum which is under NDA, so can't say much
about it.  :-(

-- 
tejun
