From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 3/3] scsi: async sd resume
Date: Mon, 10 Mar 2014 14:06:10 -0700
Message-ID: <CAPcyv4gpxxPMHJo7+iH-e+S1KVaJJH62bEBdq8_NQbeU7jTS4A@mail.gmail.com>
References: <CAPcyv4ik5GhaqZsBCA+LJ5WN=bCBPqjHgWwud1PrrKB4LarBOA@mail.gmail.com>
	<Pine.LNX.4.44L0.1403101658490.5966-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:57886 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbaCJVGL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2014 17:06:11 -0400
Received: by mail-vc0-f180.google.com with SMTP id lf12so1940944vcb.11
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2014 14:06:10 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1403101658490.5966-100000@netrider.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tejun Heo <tj@kernel.org>, James Bottomley <JBottomley@parallels.com>, Len Brown <len.brown@intel.com>, linux-scsi <linux-scsi@vger.kernel.org>, Phillip Susi <psusi@ubuntu.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Todd Brandt <todd.e.brandt@linux.intel.com>

On Mon, Mar 10, 2014 at 1:59 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 10 Mar 2014, Dan Williams wrote:
>
>> > The only thing which is a bit concerning is that this doesn't have any
>> > throttling mechanism for simultaneous wakeups.  Would this be able to
>> > blow up the PSU if used on a machine with a lot of spindles?
>>
>> Good point.  The primary benefit is completing userspace resume
>> without needlessly waiting for the disk.  For now I think it would be
>> enough to have a mutex to maintain one disk at a time.  We can follow
>> on later with something more complex to enable a max simultaneous
>> spin-up tunable.
>
> Why?  The existing code doesn't have anything like that.
>

Why follow up later, or why maintain one disk at a time?

I know at least the SCSI driver I maintained had this as a
per-low-level driver tunable.  Seems to be a good candidate for
attempting a unified platform-level tunable.  Mind you I would not be
looking to implement it anytime soon.
