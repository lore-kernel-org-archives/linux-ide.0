From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: 2.6.22.6 sata_sil device errors & timeouts
Date: Tue, 18 Sep 2007 10:34:52 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0709181032270.17786@trinity.phys.uwm.edu>
References: <76366b180709170135v6c46f3d6qd3586ea79f9abc2@mail.gmail.com>
 <46EE4679.7030600@gmail.com>  <76366b180709170904i7b2f5ab0o8605eb899d20f921@mail.gmail.com>
  <46EEB449.8010305@gmail.com>  <76366b180709171205v5783fb9ave52b7e999da96f07@mail.gmail.com>
  <76366b180709171226j5a299502q1a13f158d9b704aa@mail.gmail.com>
 <Pine.LNX.4.63.0709171433120.28104@trinity.phys.uwm.edu>
 <76366b180709171406g61f09f39la8deeb3201ad0e37@mail.gmail.com>
 <Pine.LNX.4.63.0709180028270.28104@trinity.phys.uwm.edu>
 <76366b180709180736h57f956ccld8fba04070f02408@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.phys.uwm.edu ([129.89.57.159]:56789 "EHLO
	trinity.phys.uwm.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570AbXIRPe6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Sep 2007 11:34:58 -0400
In-Reply-To: <76366b180709180736h57f956ccld8fba04070f02408@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Paprocki <andrew.m.paprocki@gmail.com>, linux-ide@vger.kernel.org

Andrew: thanks for isolating this problem.

Tejun: any thoughts?  The STRANGE_BUFFER_LENGTH problem is fixed in the 
code that Andrew is running.  The problem is provoked with '-o on' which 
goes via a TASKFILE ioctl.

Cheers,
 	Bruce

On Tue, 18 Sep 2007, Andrew Paprocki wrote:

> It appears to be the '-o on' causing the problem. If I remove that,
> the errors go away. The strange part is that according to the smartctl
> documentation, my drives support it:
>
> # smartctl -c /dev/sda
> smartctl version 5.38 [i686-pc-linux-gnu] Copyright (C) 2002-7 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
>
> === START OF READ SMART DATA SECTION ===
> General SMART Values:
> Offline data collection status:  (0x00) Offline data collection activity
>                                        was never started.
>                                        Auto Offline Data Collection: Disabled.
> Self-test execution status:      (   0) The previous self-test routine completed
>                                        without error or no self-test has ever
>                                        been run.
> Total time to complete Offline
> data collection:                 (4797) seconds.
> Offline data collection
> capabilities:                    (0x5b) SMART execute Offline immediate.
>                                        Auto Offline data collection
> on/off support.
>                                        Suspend Offline collection upon new
>                                        command.
>                                        Offline surface scan supported.
>                                        Self-test supported.
>                                        No Conveyance Self-test supported.
>                                        Selective Self-test supported.
> SMART capabilities:            (0x0003) Saves SMART data before entering
>                                        power-saving mode.
>                                        Supports SMART auto save timer.
> Error logging capability:        (0x01) Error logging supported.
>                                        General Purpose Logging supported.
> Short self-test routine
> recommended polling time:        (   1) minutes.
> Extended self-test routine
> recommended polling time:        (  80) minutes.
>
> Thanks, -Andrew
>
> On 9/18/07, Bruce Allen <ballen@gravity.phys.uwm.edu> wrote:
>> Does removing '-o on' and/or '-S on' eliminate the errors?
>>
>>
>> On Mon, 17 Sep 2007, Andrew Paprocki wrote:
>>
>>> Bruce,
>>>
>>> Just built it -- it eliminated the HSM violations, but I still get the
>>> device errors:
>>>
>>> smartmontools release 5.38 dated 2006/12/20 at 20:37:59 UTC
>>> (I see the above date, even though I verified it is built from CVS head)
>>>
>>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>>> ata2.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
>>>         res 51/04:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x1 (device error)
>>> ata2.00: configured for UDMA/100
>>> ata2: EH complete
>>>
>>> This is what it is in smartd.conf:
>>> /dev/sda -d ata -a -o on -S on
>>> /dev/sdb -d ata -a -o on -S on
>>> /dev/sdc -d ata -a -o on -S on
>>>
>>> Thanks, -Andrew
>
