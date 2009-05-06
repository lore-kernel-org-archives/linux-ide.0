From: Gwendal Grignou <gwendal@google.com>
Subject: Re: How to assess PMP register
Date: Wed, 6 May 2009 00:03:08 -0700
Message-ID: <e7510f760905060003n60535405oaf8e431963b41ddf@mail.gmail.com>
References: <fa69d4570904291849p638b849fm856be97c81340624@mail.gmail.com>
	 <49FA2763.9040409@rtr.ca>
	 <fa69d4570905032204q726728a1qd4be4800b916439a@mail.gmail.com>
	 <49FF7C2A.6030000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:46514 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbZEFHDL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 May 2009 03:03:11 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id n4673A84003021
	for <linux-ide@vger.kernel.org>; Wed, 6 May 2009 00:03:11 -0700
Received: from bwz28 (bwz28.prod.google.com [10.188.26.28])
	by wpaz29.hot.corp.google.com with ESMTP id n46738aI013871
	for <linux-ide@vger.kernel.org>; Wed, 6 May 2009 00:03:09 -0700
Received: by bwz28 with SMTP id 28so5472675bwz.26
        for <linux-ide@vger.kernel.org>; Wed, 06 May 2009 00:03:08 -0700 (PDT)
In-Reply-To: <49FF7C2A.6030000@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: s ticket <smticket@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, Mark Lord <liml@rtr.ca>

- you can not access a PMP device from user space directly because
there is no file descriptor for it.
- however, libata stores a dump of PMP registers taken after every
reset in gscr structure of the ata_device structure that represent the
PMP in the kernel. You can modify libata to print the registers you
need.
- To reset the PMP, you would have to alter ata_scsi_user_scan() to
include looping through the host port and force reset on the whole ata
port by issuing echo "- - -" > /sys/class/scsi_host/hostX/scan
Instead of ata_for_each_link(link, ap, EDGE), do
ata_for_each_link(link, ap, HOST_FIRST)

Gwendal.


On Mon, May 4, 2009 at 4:37 PM, Mark Lord <liml@rtr.ca> wrote:
> s ticket wrote:
>>>>
>>>> Is there any way to read PMP registers after hardreset/softreset?
>>>> SATA Controller is marvell 88SX7042 and driver is sata_mv.
>>>> I try to send 0xE4 and 0xE6 command to read/write PMP registers:
>>>
>>> ..
>>>>
>>>>       if (ioctl(fd, SG_IO, &io_hdr) == -1) {
>>>
>>> ..
>>>
>>> No, there is no existing way to access PMP registers from user space.
>>>
>> But what's the difference in dealing with '0xE4' and '0xE8' commands.
>> I found that only the two commands will reset the link
>
> ..
>
> There's no guaranteed way to do that (reset the link) from userspace either.
>
> You're trying to do device driver things -- those should be done inside
> the device driver in the kernel proper.
>
> Cheers
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
