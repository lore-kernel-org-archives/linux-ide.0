From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Mon, 3 Jan 2011 17:50:51 -0500
Message-ID: <AANLkTi=Kv8f3e8zhSkDohkgJqOv+XKQ_dPR=aFbpzm27@mail.gmail.com>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
 <4D2223BF.8090901@canonical.com> <AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
 <4D2247A3.2060506@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55243 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1ACWvO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 17:51:14 -0500
Received: by iyi12 with SMTP id 12so12492318iyi.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 14:51:14 -0800 (PST)
In-Reply-To: <4D2247A3.2060506@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>

On Mon, Jan 3, 2011 at 5:03 PM, Peter M. Petrakis
<peter.petrakis@canonical.com> wrote:
<snip>
>> Thanks. =A0I have a client that needs to recognize SSDs from userspa=
ce
>> and I missed the ABI.
>>
>> I was looking for the userspace ABI to be in /sys/block like the
>> topology stuff is, so I missed the userspace ABI and was confused.
>
> Ah you mean /sys/block/sda/queue/rotational.

I missed that one.  Never thought to look in queue. :(

(I don't know what SSD has to do with queue, but okay.  Please don't
answer, I've read some of the discussion before and promptly forgot
it.)

In the mean time I've found the hdparm also looks at word 217 and
reports SSD devices.  It has apparently been doing that since v9.12 or
so.  (spring 2009).

My current concern is that the logic is slowly diverging between the
kernel 2.6.36 implementation and the hdparm v9.36 implementation.

Mark (added to cc),

Would it be better if hdparm looked at /sys/block/sda/queue/rotational
instead of just using word 217 of the identify block?

The current divergence is:

1) The kernel routine  ata_id_rotation_rate() (in ata.h) is only
trusting  word 217 if its ATA7 or higher.

http://lxr.linux.no/#linux+v2.6.36/include/linux/ata.h#L799

2) There have been a couple proposed kernel patches to libata-scsi.c
to quirk in a HORKAGE flag to set the rotation_rate to 1 (meaning SSD)
for some known devices.  I don't see those being ACKed yet, but if one
ever gets in, hdparm will diverge from the kernels info since its
going straight to the identify block for its info.

Or is queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q) somehow setting
word 217 for future identify block usage by hdparm?  (I have no idea
what that call does.  It was in Bart's ATANG patch, but not Peter's.)

Bart's atang PATCH: http://marc.info/?l=3Dlinux-ide&m=3D126677421807814=
&w=3D2

Peter's patch: http://www.spinics.net/lists/linux-ide/msg38944.html

I hope one of the approaches goes in.  As I said I have a userspace
app that really needs to know if its talking to a  traditional
rotating device or a SSD, so I suspect we'll be sending in quirk
patches as we start lab testing devices.

Thanks
Greg
