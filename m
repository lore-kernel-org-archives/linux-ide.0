From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: 2.6.22.6 sata_sil device errors & timeouts
Date: Mon, 17 Sep 2007 14:35:14 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0709171433120.28104@trinity.phys.uwm.edu>
References: <76366b180709170135v6c46f3d6qd3586ea79f9abc2@mail.gmail.com>
 <46EE4679.7030600@gmail.com>  <76366b180709170904i7b2f5ab0o8605eb899d20f921@mail.gmail.com>
  <46EEB449.8010305@gmail.com>  <76366b180709171205v5783fb9ave52b7e999da96f07@mail.gmail.com>
 <76366b180709171226j5a299502q1a13f158d9b704aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.phys.uwm.edu ([129.89.57.159]:50272 "EHLO
	trinity.phys.uwm.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139AbXIQTfR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 15:35:17 -0400
In-Reply-To: <76366b180709171226j5a299502q1a13f158d9b704aa@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew.m.paprocki@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Hi Andrew,

Please build the CVS version (unreleased) of smartmontools.  The versions 
below are dated 2006/12/20 and 2006/04/12.  You need to build a code 
version based on the past few weeks of code.

Cheers,
 	Bruce


On Mon, 17 Sep 2007, Andrew Paprocki wrote:

> On 9/17/07, Andrew Paprocki <andrew@ishiboo.com> wrote:
>> On 9/17/07, Tejun Heo <htejun@gmail.com> wrote:
>>> Upgrading smartd should fix it.  Which version are you using?
>>
>> smartmontools release 5.36 dated 2006/04/12 at 17:39:01 UTC
>> smartmontools configure arguments: '--prefix=/opt/smartmontools'
>>
>> I see a newer experimental 5.37 is out. I'll give it a go and see if
>> the trace goes away.
>
> Upgrading made it worse.. I now receive the same device errors as well
> as a slew of new "HSM violation" errors when smartd starts up:>
> smartmontools release 5.37 dated 2006/12/20 at 20:37:59 UTC
> smartmontools configure arguments:  '--prefix=/opt/smartmontools'
>
> ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata5.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 126976 in
>         res 50/00:f8:00:4f:c2/00:00:00:00:00/a0 Emask 0x202 (HSM violation)
> ata5: soft resetting port
> ata5.00: configured for UDMA/100
> ata5: EH complete
>
> # smartctl -i /dev/sda
> smartctl version 5.37 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
>
> === START OF INFORMATION SECTION ===
> Model Family:     Hitachi Deskstar T7K250 series
> Device Model:     HDT722525DLA380
> Serial Number:    VDK41GT5F3S4JK
> Firmware Version: V44OA96A
> User Capacity:    250,059,350,016 bytes
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   7
> ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 1
> Local Time is:    Mon Sep 17 15:25:29 2007 EDT
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
>
> Thanks, -Andrew
>
