From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Software RAID Problem
Date: Wed, 29 Jul 2009 13:40:17 -0600
Message-ID: <4A70A5A1.1030600@gmail.com>
References: <1248798289.4a6f26510c218@myaccount.bayarea.net> <4A6FAF54.1060902@kernel.org> <4A706D78.7000107@bayarea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f201.google.com ([209.85.216.201]:53663 "EHLO
	mail-px0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbZG2TkV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jul 2009 15:40:21 -0400
Received: by pxi39 with SMTP id 39so638973pxi.4
        for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2009 12:40:21 -0700 (PDT)
In-Reply-To: <4A706D78.7000107@bayarea.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Broman <rbroman@bayarea.net>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 07/29/2009 09:40 AM, Randy Broman wrote:
> Per your instructions .... I tail -f'd /var/log/dmesg and
> /var/l0g/messages,
> and then executed the four mdadm commands below, for the faulty array.
> After removing and re-adding the faulty disk partition to the array, the
> array
> returns to faulty state almost immediately. During the process, dmesg
> didn't
> show anything, but the information written to /var/log/messages is at the
> bottom hereto.
>
> I suppose one answer is that there's a hardware issue with the array, or
> one of the disks. But that would be surprising to me - both the hardware
> array and the disks are new, and the setup (hardware/software/RAID) worked
> fine until I tried to upgrade my kernel. Possibly RAID-related formats are
> different between kernel 2.6.28 and 2.6.31????
>
> Anyway, would appreciate diagnosis/recommendations ...

The output looks a bit scrambled and seems to be missing certain lines 
(we see hardresets but not any error that triggered it). Sometimes that 
seems to happen if disk problems are occurring (kernel logger buffer 
overflows or something). If the kernel messages are showing up in 
/var/log/messages then they should be showing up in dmesg and would be 
more complete. Can you check again?
