From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Bugme-new] [Bug 9533] New: 2.6.24-rc4: some ahci/acpi interaction
 causes delays during boot
Date: Wed, 12 Dec 2007 17:20:47 +0900
Message-ID: <475F99DF.7070903@gmail.com>
References: <bug-9533-10286@http.bugzilla.kernel.org/>	<20071210125243.df6b441e.akpm@linux-foundation.org> <20071210125543.80b1e841.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:45318 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbXLLIUy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 03:20:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so245175wah.23
        for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 00:20:54 -0800 (PST)
In-Reply-To: <20071210125543.80b1e841.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rjw@sisk.pl, bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Morton wrote:
> On Mon, 10 Dec 2007 12:52:43 -0800
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> On Mon, 10 Dec 2007 05:55:20 -0800 (PST)
>> bugme-daemon@bugzilla.kernel.org wrote:
>>
>>> http://bugzilla.kernel.org/show_bug.cgi?id=9533
>> Another box-killing regression to track, please.  Either ATA or ACPI.
> 
> er, no, not box-killing - just scary warnings.
> 
> It's not clear what "kernel doesn't get to userland yet" is referring to - 
> something else I guess.
> 
> Your desire to avoid doing a bisection search is a good one - I've been
> trying to do one for a couple of days on and off and there are so many
> fatally buggy bisection points between 2.6.23 and 2.6.24-rc1 that I've
> given up on the attempt.

This one will be fixed by ACPI fixes which are currently being tested.
I just need to get one more test result.  I'll post the patch to 9533 too.

Thanks.

-- 
tejun
