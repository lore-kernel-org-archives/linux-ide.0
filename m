From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc4-git5: Reported regressions from 2.6.23
Date: Sun, 09 Dec 2007 15:52:55 +0900
Message-ID: <475B90C7.4070505@gmail.com>
References: <200712080340.49546.rjw@sisk.pl> <20071208013631.3147986a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:47973 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbXLIGxE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 01:53:04 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2539588wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Dec 2007 22:53:03 -0800 (PST)
In-Reply-To: <20071208013631.3147986a.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org

Hello,

Andrew Morton wrote:
>> Subject		: PATA scan: ACPI Exception AE_AML_PACKAGE_LIMIT... is beyond end of object
>> Submitter	: Hans de Bruin <bruinjm@xs4all.nl>
>> References	: http://bugzilla.kernel.org/show_bug.cgi?id=9320
>> Handled-By	: Robert Moore <Robert.Moore@intel.com>
>> 		  Tejun Heo <htejun@gmail.com>
>> 		  Fu Michael <michael.fu@intel.com>
>> Patch		: 
>>
> 
> A number of other people are seeing the same thing and Tejun is
> putting in a blacklist of machines which cannot use libata+acpi.
> That patch is not yet in any git tree which I pull.
> 
> AFACIT the machines kepe working OK - there's just some nasty dmesg
> spew.
> 
> If any machines _are_ breaking then this could cause real problems
> and I'd prefer that we either go for a whitelist or arrange to
> detect the condition and fall back to non-acpi ata.

The pending patchset should make ATA ACPI quite resistant to failures.
Known bad boards can be blacklisted (currently only one is on the
list), ATA ACPI is disabled quicker if ACPI evalution fails, execution
errors are handled better and commands which are intended to help the
vendor instead of the user are filtered.  So, I think we have enough
safety nets.

Thanks.

-- 
tejun
