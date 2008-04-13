From: Tejun Heo <htejun@gmail.com>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Sun, 13 Apr 2008 11:39:04 +0900
Message-ID: <48017248.4030600@gmail.com>
References: <200804021524.27222.elendil@planet.nl> <200804021820.04610.elendil@planet.nl> <20080402194938.GI24237@csclub.uwaterloo.ca> <200804031947.07674.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:52142 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbYDMCjM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 22:39:12 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1062321wff.4
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 19:39:11 -0700 (PDT)
In-Reply-To: <200804031947.07674.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Frans Pop wrote:
> On Wednesday 02 April 2008, Lennart Sorensen wrote:
>>> Yes, that could be one way to implement it: load it and then check if
>>> that added any devices.
>> Well even if you see other disks doesn't mean you don't also have an old
>> IDE controller you want to use, so probably load it and see if it finds
>> any disks is the best bet after loading all the other probeable drivers
>> first.
> 
> I've decided (at least for now) to only do this f /sys/bus/isa is present.
> I added a check to see if there are additional devices in /sys/block after 
> loading ide-generic to decide whether or not to also include it in the 
> initrd for the installed system.
> 
> /sys/bus/isa is present for this machine so it works even if (as Ondrej 
> suggests) the controller is not actually on the ISA bus. We can always 
> extend the test if it turns out systems without ISA bus are also affected.
> 
> I'll also send out a call for testing specifically for this issue.
> 
> Thanks to you and Ondrej for the discussion.

Please be advised that some modern controllers are dual interfaced. 
Native one and legacy one.  The legacy one is SFF compliant and 
depending on configuration may appear at legacy IO addresses, so if you 
aren't careful, you can end up with two drivers driving the same 
hardware which usually doesn't end too well.  Loading generic drivers 
w/o knowing that it's needed is quite dangerous.  I would strongly 
advise against it.

-- 
tejun
