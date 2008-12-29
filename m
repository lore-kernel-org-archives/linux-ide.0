From: Grant Grundler <grundler@google.com>
Subject: Re: Frozen drives when using SiI3726
Date: Mon, 29 Dec 2008 11:20:01 -0800
Message-ID: <da824cf30812291120x1ed3f554lb7bdfe25427cecb3@mail.gmail.com>
References: <20E60A0E-48E9-4942-851D-E20C012F5B89@ibink.com>
	 <495894AB.8010404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:27037 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYL2TUH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 14:20:07 -0500
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id mBTJK4V7024569
	for <linux-ide@vger.kernel.org>; Mon, 29 Dec 2008 11:20:05 -0800
Received: from bwz13 (bwz13.prod.google.com [10.188.26.13])
	by wpaz1.hot.corp.google.com with ESMTP id mBTJJdmv027068
	for <linux-ide@vger.kernel.org>; Mon, 29 Dec 2008 11:20:02 -0800
Received: by bwz13 with SMTP id 13so13950467bwz.3
        for <linux-ide@vger.kernel.org>; Mon, 29 Dec 2008 11:20:02 -0800 (PST)
In-Reply-To: <495894AB.8010404@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Tim Nufire <linux_ide_tim@ibink.com>, linux-ide@vger.kernel.org

On Mon, Dec 29, 2008 at 1:13 AM, Tejun Heo <tj@kernel.org> wrote:
> Hi,
>
> Tim Nufire wrote:
>> Hello,
>>
>> I'm building a server using 9 SiI3726 based port multiplier backplanes
>> connected to cards using SiI3132 (PCI Express) and SiI3124 (PCI). The
>> drives are configured into 5 RAID6 groups of 9 drives each such that
>> each array has 1 drive from each backplane. During the initial RAID
>> synchronization one of the backplanes failed and restarted (see dmesg
>> output below). While this did not disrupt the RAID groups this time, the
>> reset took about 25 seconds and could easily have caused one or more
>> drives to fail.
>>
>> Is there anything I can do to prevent failures like this?
>
> The reset was triggered by a timeout which probably have taken around
> or more than 30 secs, so the array probably experienced disruption
> which is about a minute long.  The failure latency is a bit
> unfortunate at the moment.  :-(
>
> Also, the timeout is one of the most generic failure mode there is.
> It can be triggered by virtually anything including transmission
> failure, power quality issues, drive problems and whatnot.  So, it's
> impossible to tell what went wrong with the provided information.

Tejun,
The only other possible major issue not listed above I can think of is
Sil3276 firmware rev. The data sheet (*) "EEPROM Speicifications"
on Page 20 says the firmware is versioned.
But the data sheet doesn't specify how to read it.
Can you ask Silicon Image to publish how to read the firmware rev?

(*) Data sheet available from
http://www.siliconimage.com/docs/SiI-DS-0121-C1.pdf

Also SATA_PMP_GSCR_REV  (Spec compliance, not FW rev) seems
to be used twice:

include/linux/ata.h:
#define sata_pmp_gscr_rev(gscr)         (((gscr)[SATA_PMP_GSCR_REV] >>
8) & 0xff)

drivers/ata/libata-pmp.c:sata_pmp_spec_rev_str()

Would it make sense to rename one or the other so they match?
The difference is one returns a string and the other a u8 value.
Both take the same parameter.

thanks,
grant

>  It
> could be an one-time fluke - e.g. bad sectors which developed during
> storage and shipping and RAID sync makes the firmware think what to do
> about it for a long time - or something more systematic -
> e.g. slightly bad connection on the backplane side or sub-par power
> which slightly chokes when all drives are pulling juice out of it.
>
> Unfortunately, the only way to debug would be keeping an eye on
> whether such failures repeat and if so when and where - whether it
> always happen on the same chassis, slot or drive (by exchaning
> drives), etc...
>
> Please let us know when you find out more.
>
> Happy new year.
>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
