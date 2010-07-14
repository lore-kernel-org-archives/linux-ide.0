From: "Paul Check" <paul@thechecks.ca>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Wed, 14 Jul 2010 13:58:10 -0400
Message-ID: <0d9ccbbb9ed0fb46dc9497888cd92c6e.squirrel@thechecks.ca>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
    <4B5D26EF.4030709@kernel.org> <loom.20100205T041929-66@post.gmane.org>
    <12193ff15b0deef3609ea93f54e5b485.squirrel@thechecks.ca>
    <13096cdf5e0e6704e30364a746e60467.squirrel@thechecks.ca>
    <8276efbfebcbfc3e58033ab8d5996d9d.squirrel@thechecks.ca>
    <4C3DACFF.2060504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from d72-38-7-254.commercial1.cgocable.net ([72.38.7.254]:1528 "EHLO
	max" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752668Ab0GNR6N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jul 2010 13:58:13 -0400
In-Reply-To: <4C3DACFF.2060504@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Paul Check <paul@thechecks.ca>, linux-ide@vger.kernel.org

I applied your patch to the 2.6.34 kernel, and on my very first reboot had
a drive missing. What information do you want? Just /var/log/messages?

I don't want to keep rebooting forever. Was this patch supposed to fix the
problem, or just give you information to debug? Is the problem even known?

Regards, Paul


> Hello,
>
> On 07/12/2010 06:36 PM, Paul Check wrote:
>>> Tejun & Co:
>>>
>>> I have finally upgraded to the 2.6.34 kernel, and I am still having
>>> problems with some of my drives not coming up some of the time
>>> (different
>>> drives, at different times, never more than one).
>>>
>>> Here are some lines from /var/log/messages on the most recent boot
>>> below.
>>> Do you have any suggestions for this? I'm getting tired of having to
>>> reconstitute my raid 30-50% of the time, and will try anything to see
>>> if
>>> it fixes. Note the "link up (unknown)" and "link down" lines. I don't
>>> know
>>> what should appear, but I have 4 hard drives and one optical drive
>>> plugged
>>> into 5 of the 6 SATA ports on the board.
> ...
>>> Jul 12 12:25:22 min kernel: [    2.078489] ata2.01: SATA link up
>>> <unknown>
>>> (SStatus 300 SControl 123)
>
> Hmm, yeah, it seems like SCR access via SIDPR is more flaky than
> covered by the previous commit.  There's another thread where similar
> problem is being debugged.  Can you please do the following?  I'm
> attaching patch here too.
>
>   http://thread.gmane.org/gmane.linux.kernel/1005983/focus=46749
>
> Thanks.
>
> --
> tejun
>


