From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: sata_via issue for VIA Epia SP8000 in 2.6.18[.1]?
Date: Tue, 24 Oct 2006 16:23:27 +0200
Message-ID: <453E21DF.2070107@xs4all.nl>
References: <453B61D9.9060707@xs4all.nl> <453D5870.20308@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:29705 "EHLO
	smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP
	id S1030392AbWJXOXZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Oct 2006 10:23:25 -0400
In-Reply-To: <453D5870.20308@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

Daniel Drake wrote:
>> Some burbs:
>>
>> Links is up but  SStatus 113 SControl 300
>> qc timeout (cmd 0xec)
>> failed to IDENTIFY
>> This results in a kernel panic.
> 
> Try this patch:
> http://marc.theaimsgroup.com/?l=git-commits-head&m=116121959622812&q=raw

Works well on VIA Epia SP8000 (w/ SATA) and does not break EK8000 (just
PATA).
Thanks very much!

Kind regards,
Udo

