From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: SSD slowdown with 3.3.X?
Date: Fri, 20 Apr 2012 11:23:25 -0400
Message-ID: <x49ehriwhoy.fsf@segfault.boston.devel.redhat.com>
References: <4F8F7533.6020300@gmail.com> <4F8F82EC.1060708@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36987 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932197Ab2DTPX2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Apr 2012 11:23:28 -0400
In-Reply-To: <4F8F82EC.1060708@teksavvy.com> (Mark Lord's message of "Wed, 18
	Apr 2012 23:13:48 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Joe Ceklosky <jfceklosky@gmail.com>, linux-ide@vger.kernel.org

Mark Lord <kernel@teksavvy.com> writes:

> On 12-04-18 10:15 PM, Joe Ceklosky wrote:
>> All,
>> 
>> Has anyone reported slowness using SSD's on kernel 3.3.X compiled
>> as 32-bit PAE with 16 Gigs of memory (I know I need to update to 64-bit
>> already, will do with Fedora 17)?
>> 
>> I am see terrible r/w to an SSD using 3.3.2.  When I boot the same machine
>> and SSD back in 3.2.15 all is fine.
>
>
> Double check which IO-scheduler the kernel is choosing.
> For SSDs, it is normally "noop", but I noticed "cfq"
> being chosen instead for some reason.

The default I/O scheduler is the default I/O scheduler.  Drivers may
override this (some high-end PCIe SSD drivers do this, and I think s390
block drivers do as well), but in general the default is left alone.

Cheers,
Jeff
