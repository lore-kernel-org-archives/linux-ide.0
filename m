From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA_SIL
Date: Fri, 02 Nov 2007 10:11:04 +0900
Message-ID: <472A7928.2060702@gmail.com>
References: <1193781389.26314.9.camel@ws1.fransdb.nl>	 <4729126F.1000108@gmail.com> <1193955948.17609.31.camel@ws1.fransdb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:12161 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbXKBBLN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2007 21:11:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so769145wah
        for <linux-ide@vger.kernel.org>; Thu, 01 Nov 2007 18:11:12 -0700 (PDT)
In-Reply-To: <1193955948.17609.31.camel@ws1.fransdb.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans de Boer <frans@fransdb.nl>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

[restoring linux-ide, please don't drop cc]

Frans de Boer wrote:
> Hello sir,
> 
> I just checked: the SuSE 2.6.22.9-0.4 source for sata_sil.c (among
> others) is NOT the same as the stock 2.6.22.9. Looking at your reply, I
> quess that I have to skip 2.6.23 and use the next 2.6.24 release?

Is it sata_sil or sata_sil24?  You were talking about sil24 in the
original message.

> On a more modern system, - without the sil chips - SuSE 10.3 with the
> newer 2.6.23.1 kernel is working just fine.
> 
> Do you  still like to recieve my report as suggested by you?

Yeah, it should just work.  Thanks.

-- 
tejun
