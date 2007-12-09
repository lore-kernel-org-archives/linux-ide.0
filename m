From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc4-git5: Reported regressions from 2.6.23
Date: Mon, 10 Dec 2007 00:46:57 +0900
Message-ID: <475C0DF1.50108@gmail.com>
References: <200712080340.49546.rjw@sisk.pl> <20071208013631.3147986a.akpm@linux-foundation.org> <20071208101256.GA25807@rhlx01.hs-esslingen.de> <20071208022001.155e0c52.akpm@linux-foundation.org> <20071208105557.GA27646@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:48324 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbXLIPrG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 10:47:06 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1308271rvb
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 07:47:05 -0800 (PST)
In-Reply-To: <20071208105557.GA27646@rhlx01.hs-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Andreas Mohr wrote:
> Hi,
> 
> On Sat, Dec 08, 2007 at 02:20:01AM -0800, Andrew Morton wrote:
>>> Does this report now win me the lucky draw, pretty please? ;)
>> nah, you have to cc the acpi guys to get a prize ;)
> 
> Thought so shortly, but missed it.
> 
>> Andreas, please do separately report that WOL problem too..
> 
> Local setup issue only, at least this one *isn't* a 2.6.24-rc regression. ;)
> 
>> Our list just reached 30.
> 
> Oh, so this is in fact a separate issue? Wasn't sure, couldn't do
> enough analysis of similar cases.
> 
> Will test any (already submitted!) suggestions ASAP.

Please post full kernel boot log and the result of 'lspci -nn'.

Thanks.

-- 
tejun
