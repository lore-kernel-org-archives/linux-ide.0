From: Borislav Petkov <bp@alien8.de>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Mon, 10 Sep 2012 22:51:22 +0200
Message-ID: <20120910205121.GA11370@liondog.tnic>
References: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com>
 <20120825113301.GA15210@liondog.tnic>
 <CAPL5yKdj2NrtQ0edWLjv6nefkcAG0VacQgSxPhuZ_TLpXeb+0Q@mail.gmail.com>
 <20120902072420.GC21982@liondog.tnic>
 <CAPL5yKcyzf1ta9Vc8Sh0EKCxBhonYjRFH7dnMEDBHbFYDh7u5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:53901 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab2IJUvZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Sep 2012 16:51:25 -0400
Content-Disposition: inline
In-Reply-To: <CAPL5yKcyzf1ta9Vc8Sh0EKCxBhonYjRFH7dnMEDBHbFYDh7u5w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Merillat <dan.merillat@gmail.com>
Cc: Adko Branil <adkobranil@yahoo.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sun, Sep 02, 2012 at 08:38:14PM -0400, Dan Merillat wrote:
> > Hmm, can you enable all the debug statements in the driver?
> >
> > Simply edit drivers/cpufreq/powernow-k8.c by adding
> >
> > #define DEBUG
> 
> It didn't add anything new, got:

But it did, actually. The "trying to register..." is a pr_debug call for
example.

> [   44.491795] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ (2 cpu cores) (version 2.20.00)
> [   44.491852] trying to register driver powernow-k8

this is cpufreq_register_driver()

> [   44.491893] adding CPU 0
> [   44.491955] processor_perflib-0423 [4294967293] processor_get_performa: ACPI-based processor performance control unavailable

this is acpi_processor_register_performance called by powernow_k8_cpu_init_acpi

> [   44.492103] register performance failed: bad ACPI data: -5
> (I added the return value to the debug)

Yep, cool. This tells us that it is -EIO which means
that acpi_processor_register_performance returns -EIO
after trying acpi_processor_get_performance_info. The "..
performance control unavailable" message above tells us that
acpi_processor_get_performance_info fails when trying to get the _PCT
handle.

So, to recheck: are you sure your "Cool'n'quiet" option in the BIOS is
enabled? If not, please enable it and retest.

Thanks.

-- 
Regards/Gruss,
    Boris.
