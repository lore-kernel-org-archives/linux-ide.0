From: Dan Merillat <dan.merillat@gmail.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Sat, 1 Sep 2012 08:45:56 -0400
Message-ID: <CAPL5yKdj2NrtQ0edWLjv6nefkcAG0VacQgSxPhuZ_TLpXeb+0Q@mail.gmail.com>
References: <1345858271.82172.YahooMailNeo@web124705.mail.ne1.yahoo.com>
	<20120825113301.GA15210@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36097 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2IAMp5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2012 08:45:57 -0400
Received: by dady13 with SMTP id y13so2589530dad.19
        for <linux-ide@vger.kernel.org>; Sat, 01 Sep 2012 05:45:57 -0700 (PDT)
In-Reply-To: <20120825113301.GA15210@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Adko Branil <adkobranil@yahoo.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sat, Aug 25, 2012 at 7:33 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Aug 24, 2012 at 06:31:11PM -0700, Adko Branil wrote:
>> To add some more info - i just noticed in dmesg of the latest kernel-2.5.2 some suspicious lines:
>>
>>       * [   44.251706] microcode: AMD CPU family 0xf not supported
>>       * [   44.255721] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ (2 cpu cores) (version 2.20.00)
>>       * [   44.255736] [Firmware Bug]: powernow-k8: No compatible ACPI _PSS objects found.
>>       * [   44.255736] [Firmware Bug]: powernow-k8: Try again with latest BIOS.
>>
>> Coult it be related to the crashes , and should i update my bios ?
>
> No.
>
> Try to enable the Cool'n'Quiet option in your BIOS - this message should
> disappear then.
>
> Btw, there's a patch to make this more understandable:
>
> http://marc.info/?l=linux-kernel&m=134262430326493

I haven't been in my BIOS in years, but powernow-k8 quit working
sometime after 3.2 when the ACPI bits were reworked.  So whatever
broke it, it's 100% software.  Not something I use a lot so I haven't
done an exact regression on it, but:
Feb 19 18:23:32 fileserver kernel: [    0.000000] Linux version 3.2.0
(harik@fileserver) (gcc version 4.5.3 (Debian 4.5.3-3) ) #1 SMP Mon
Jan 23 21:57:27 EST 2012
Feb 19 18:23:32 fileserver kernel: [    1.268123] powernow-k8: Found 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ (2 cpu cores) (version
2.20.00)
Feb 19 18:23:32 fileserver kernel: [    1.268206] powernow-k8: fid
0x10 (2400 MHz), vid 0xc
Feb 19 18:23:32 fileserver kernel: [    1.268242] powernow-k8: fid 0xe
(2200 MHz), vid 0xe
Feb 19 18:23:32 fileserver kernel: [    1.268277] powernow-k8: fid 0xc
(2000 MHz), vid 0x10
Feb 19 18:23:32 fileserver kernel: [    1.268313] powernow-k8: fid 0xa
(1800 MHz), vid 0x10
Feb 19 18:23:32 fileserver kernel: [    1.268348] powernow-k8: fid 0x2
(1000 MHz), vid 0x12

vs

Jul 31 00:33:09 fileserver kernel: [    0.000000] Linux version
3.4.0-dan-00002-ga84219d (harik@fileserver) (gcc version 4.6.2 (Debian
4.6.2-12) ) #2 SMP PREEMPT Mon May 21 09:36:23 EDT 2012
Jul 31 00:33:09 fileserver kernel: [    0.972056] powernow-k8: Found 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4600+ (2 cpu cores) (version
2.20.00)
Jul 31 00:33:09 fileserver kernel: [    0.972118] [Firmware Bug]:
powernow-k8: No compatible ACPI _PSS objects found.
Jul 31 00:33:09 fileserver kernel: [    0.972120] [Firmware Bug]:
powernow-k8: Try again with latest BIOS.
