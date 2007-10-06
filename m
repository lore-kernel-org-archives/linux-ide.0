From: Tejun Heo <htejun@gmail.com>
Subject: Re: smartd causing SATA timeouts on sleeping drives
Date: Sun, 07 Oct 2007 05:15:44 +0900
Message-ID: <4707ECF0.9030800@gmail.com>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:48869 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbXJFUPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Oct 2007 16:15:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1070460wah
        for <linux-ide@vger.kernel.org>; Sat, 06 Oct 2007 13:15:51 -0700 (PDT)
In-Reply-To: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Andrew Paprocki wrote:
> Tejun/Bruce,
> 
> I tracked down the source of timeouts I have been frequently getting.
> It appears smartd is not properly handling drives that are spun down
> by the BIOS ACPI settings. I have SATA timeouts which occur every half
> hour (the default -i 1800 in smartd) that do not occur when smartd is
> not running. The drives smartd is configured to look at have a sleep
> time configured in the BIOS. When the drives are asleep, I get a soft
> reset every half hour as smartd attempts to access the drives. While
> in this state, smartd also reports bad state to syslog (e.g.
> temperature changes to 200C). Just for comparison, hddtemp knows the
> drives are sleeping:
> 
> # hddtemp /dev/sda
> /dev/sda: Hitachi HDS721010KLA330                 : drive is sleeping
> # ls /storage
> ... wakes up the drives ...
> # hddtemp /dev/sda
> /dev/sda: Hitachi HDS721010KLA330                 :  29 C or  F
> 
> I'm pasting the example cmd / timeout error / soft reset below. Also,
> I'm pasting the invalid settings which smartd detects when in this
> state. What needs to change for smartd to recognize drives are
> sleeping and either not perform its checks, or forcefully wake them up
> to perform them? (Should that be a configuration parameter in smartd?)

smartd should probably issue CHECK POWER MODE (0xe5) before issuing
other commands.  Bruce?

Thanks.

-- 
tejun
