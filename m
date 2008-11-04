From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm-9.2 now available: w/ DCO and firmware support
Date: Tue, 04 Nov 2008 13:08:22 -0500
Message-ID: <49108F96.8010902@rtr.ca>
References: <490F4030.5030709@rtr.ca> <87f94c370811041001ucd76d27lc948c553ad2a381e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:40326 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695AbYKDSHm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 13:07:42 -0500
In-Reply-To: <87f94c370811041001ucd76d27lc948c553ad2a381e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Greg Freemyer wrote:
> On Mon, Nov 3, 2008 at 1:17 PM, Mark Lord <liml@rtr.ca> wrote:
>> hdparm v9.2 is now available from sourceforge.
>>
>>        http://sourceforge.net/projects/hdparm/
>>
>> New since v8.9 are:
>>
>> 1. Support for Device Configuration Overlay (DCO),
>>  with the --dco-identify, --dco-freeze, and --dco-restore flags.
>>  DCO is a feature set that enables vendors/OEMs to disable/hide
>>  certain drive features (eg. NCQ, LBA48, ..) for whatever reason
>>  (eg. compatibility with a specific b0rked BIOS).
>>  This release of hdparm can display/reset DCO, but not selectively
>>  disable features yet.
..
> I'm very happy to see the DCO support go in.
> 
> There is a small army of "Computer Forensic" examiners which do their
> forensic imaging via Linux and I'm sure many will feel the same.
..

Mmm.. never thought about that much before now,
but DCO is a nifty way to hide much of a drive from prying eyes.
Eg. Use DCO to restrict the drive to LBA28 accessible sectors
and also turn off LBA48 support, and then a lot of space becomes "hidden". 

Until now!

Cheers
