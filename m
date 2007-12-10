From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc4-git5: Reported regressions from 2.6.23
Date: Mon, 10 Dec 2007 11:25:12 +0900
Message-ID: <475CA388.9050805@gmail.com>
References: <fa.qQhD8aJpiTOFaZqjRYwoaG7YT1c@ifi.uio.no> <fa.yaP86AixGhz5Q7eXSu04pIQp6ho@ifi.uio.no> <fa.c3k8VKWAx4HIo9zXWbL5Ek0oSBw@ifi.uio.no> <fa.C8ACnOhs8bXB++vmugf5F34JcJg@ifi.uio.no> <fa.5o6E6S0UWnARbQPxLe30TvLQIiY@ifi.uio.no> <475AE150.9050306@shaw.ca> <20071209213642.GA27096@rhlx01.hs-esslingen.de> <20071210000429.GA3916@rhlx01.hs-esslingen.de> <20071210004959.GA23280@rhlx01.hs-esslingen.de> <475C9643.2000202@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:13679 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbXLJCZV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 21:25:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1446014rvb
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 18:25:20 -0800 (PST)
In-Reply-To: <475C9643.2000202@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Andreas Mohr <andi@lisas.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Robert Hancock wrote:
> And you're quite right in your comment that we are often too quick to
> blacklist hardware instead of looking into why it really is failing.
> ACPI is one of those areas where we often just need to figure out how to
> be bug-to-bug compatibile with what Windows is doing..

In the spirit of not blacklisting without looking deep into ACPI code,
can somebody familiar with ASL take a look at comment 11 of bug 9320?

  http://bugzilla.kernel.org/show_bug.cgi?id=9320#c11

This is libata calling _GTM to find out how the BIOS configured the
device to determine cable type.

Thanks.

-- 
tejun
