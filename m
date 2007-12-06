From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil issue on 2.6.22
Date: Thu, 06 Dec 2007 09:25:00 +0900
Message-ID: <4757415C.9010906@gmail.com>
References: <47434526.7010304@verizonbusiness.com> <474CC29E.8020102@gmail.com> <475032AF.6090001@verizonbusiness.com> <4754C15C.1020107@gmail.com> <4756B5B2.1010302@verizonbusiness.com> <4756B6D3.9020307@gmail.com> <4756BA80.1020902@verizonbusiness.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:31256 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbXLFAZH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 19:25:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so21546rvb
        for <linux-ide@vger.kernel.org>; Wed, 05 Dec 2007 16:25:07 -0800 (PST)
In-Reply-To: <4756BA80.1020902@verizonbusiness.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mark.paulus@verizonbusiness.com
Cc: linux-ide@vger.kernel.org

Mark Paulus wrote:
> Yes, I am.  It's a SD-ADSAIDE-S1, with a sil3611ct80 chip on board.
> 
> My question would be, what makes the 2.6.22 kernel different enough
> than the 2.6.18 kernel that this setup is causing problems in .22.
> Is .18 masking the problems, or is .22 just looking at things with
> tighter tolerences, so it's more sensitive?

That's to be investigated.  There's another report of similar problem.
Can you please add yourself to the following bugzilla and add your log
there?

http://bugzilla.kernel.org/show_bug.cgi?id=9505

Thanks.

-- 
tejun
