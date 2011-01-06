From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Thu, 6 Jan 2011 15:41:45 -0500
Message-ID: <AANLkTiksg1a1joizFhJ34yGHZpbdaCKt5HcWnMoyEkWp@mail.gmail.com>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
	<4D2223BF.8090901@canonical.com>
	<AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
	<4D2247A3.2060506@canonical.com>
	<4D25E96D.10400@computer.org>
	<AANLkTin1ZjPmbk1M=9-SGStU7zLUozwxX7Ddtu53xNE2@mail.gmail.com>
	<AANLkTim=AxrJybApL-5oG7+i08tkKofk0eyP+3XhjhBJ@mail.gmail.com>
	<yq18vyxq15w.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33142 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab1AFUl4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 15:41:56 -0500
Received: by bwz15 with SMTP id 15so16757477bwz.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 12:41:46 -0800 (PST)
In-Reply-To: <yq18vyxq15w.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, Jan Ceuleers <jan.ceuleers@computer.org>, "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, Jan 6, 2011 at 2:31 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Greg" == Greg Freemyer <greg.freemyer@gmail.com> writes:
> But the question is whether it's worth the hassle since there a many of
> these devices out there and it is unclear whether treating them as
> non-rotational is a win. If you can provide some compelling performance
> improvement numbers for a particular device we can look into adding a
> quirk for it.

In an ideal world where information and engineers are cost-free...

if a device is non-rotational, we should know this, whether it's
ancient compact flash, or gigabyte's DRAM-based ATA device, or modern
SSD.  It shouldn't be a question of whether or not treating a
non-rotational device as a non-rotational device is performance win --
because if you're asking that question, it might imply areas where we
are making invalid assumptions about certain classes of non-rotational
devices :)

So while the two approaches presented are not remotely optimal in
terms of identifying all the non-rotational ATA devices out in the
field, I do think there is value in accurately flagging all
non-rotational devices as such.  But it is, IMO, not important to have
this list in the kernel; if such a project is undertaken, a userspace
pkg such as storage-fixup seems more appropriate.

     Jeff
