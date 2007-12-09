From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc4-git5: Reported regressions from 2.6.23
Date: Mon, 10 Dec 2007 00:11:01 +0900
Message-ID: <475C0585.3090304@gmail.com>
References: <200712080340.49546.rjw@sisk.pl> <20071208013631.3147986a.akpm@linux-foundation.org> <475B90C7.4070505@gmail.com> <200712091520.04740.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:25561 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbXLIPLP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 10:11:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2752359wah
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 07:11:15 -0800 (PST)
In-Reply-To: <200712091520.04740.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org

Rafael J. Wysocki wrote:
>>> If any machines _are_ breaking then this could cause real problems
>>> and I'd prefer that we either go for a whitelist or arrange to
>>> detect the condition and fall back to non-acpi ata.
>> The pending patchset should make ATA ACPI quite resistant to failures.
> 
> Are you going to push it for 2.6.24?

Yeah, I'm hoping so.  Maybe command filtering should wait till 2.6.25
but the rest, yeap.

-- 
tejun
