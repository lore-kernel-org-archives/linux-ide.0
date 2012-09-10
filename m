From: Dan Merillat <dan.merillat@gmail.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Mon, 10 Sep 2012 17:29:50 -0400
Message-ID: <CAPL5yKdNJnKoWQSKb6-bjDAGP4sEtvUdfR+bZb9XEhseE=SMYg@mail.gmail.com>
References: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com>
	<20120825113301.GA15210@liondog.tnic>
	<CAPL5yKdj2NrtQ0edWLjv6nefkcAG0VacQgSxPhuZ_TLpXeb+0Q@mail.gmail.com>
	<20120902072420.GC21982@liondog.tnic>
	<CAPL5yKcyzf1ta9Vc8Sh0EKCxBhonYjRFH7dnMEDBHbFYDh7u5w@mail.gmail.com>
	<20120910205121.GA11370@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54622 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab2IJV3u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Sep 2012 17:29:50 -0400
Received: by pbbrr13 with SMTP id rr13so3072137pbb.19
        for <linux-ide@vger.kernel.org>; Mon, 10 Sep 2012 14:29:50 -0700 (PDT)
In-Reply-To: <20120910205121.GA11370@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Adko Branil <adkobranil@yahoo.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, Sep 10, 2012 at 4:51 PM, Borislav Petkov <bp@alien8.de> wrote:
>> [   44.491795] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ (2 cpu cores) (version 2.20.00)
>> [   44.491852] trying to register driver powernow-k8
>
> this is cpufreq_register_driver()
>
>> [   44.491893] adding CPU 0
>> [   44.491955] processor_perflib-0423 [4294967293] processor_get_performa: ACPI-based processor performance control unavailable
>
> this is acpi_processor_register_performance called by powernow_k8_cpu_init_acpi
>
>> [   44.492103] register performance failed: bad ACPI data: -5
>> (I added the return value to the debug)
>
> Yep, cool. This tells us that it is -EIO which means
> that acpi_processor_register_performance returns -EIO
> after trying acpi_processor_get_performance_info. The "..
> performance control unavailable" message above tells us that
> acpi_processor_get_performance_info fails when trying to get the _PCT
> handle.
>
> So, to recheck: are you sure your "Cool'n'quiet" option in the BIOS is
> enabled? If not, please enable it and retest.

It has two states, "Automatic" and "Disabled", but anything
OS-controlled (such as virtualization) has the same two states.  It's
set to "Automatic".

I can probably boot back to a 3.2 where it was working, what ACPI
debugging would be useful to you from a good kernel?
