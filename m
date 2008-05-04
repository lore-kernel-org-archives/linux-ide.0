From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCH] LBA28/LBA48 off-by-one bug in ata.h
Date: Sun, 4 May 2008 14:33:44 -0400
Message-ID: <87f94c370805041133w1cea3c85k2eb1185be6c374d8@mail.gmail.com>
References: <481C224F.10301@rakugaki.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:54127 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbYEDSdp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 May 2008 14:33:45 -0400
Received: by an-out-0708.google.com with SMTP id d40so477215and.103
        for <linux-ide@vger.kernel.org>; Sun, 04 May 2008 11:33:44 -0700 (PDT)
In-Reply-To: <481C224F.10301@rakugaki.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Taisuke Yamada <tai@rakugaki.org>
Cc: linux-ide@vger.kernel.org

On Sat, May 3, 2008 at 4:29 AM, Taisuke Yamada <tai@rakugaki.org> wrote:
> Hi.
>
>  I recently bought 3 HGST P7K500-series 500GB SATA drives and
>  had trouble accessing the block right on the LBA28-LBA48 border.
>  Here's how it fails (same for all 3 drives):
>
>   # dd if=/dev/sdc bs=512 count=1 skip=268435455 > /dev/null
>   dd: reading `/dev/sdc': Input/output error
>   0+0 records in
>   0+0 records out
>   0 bytes (0 B) copied, 0.288033 seconds, 0.0 kB/s
>   # dmesg
>   ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>   ata1.00: BMDMA stat 0x25
>   ata1.00: cmd c8/00:08:f8:ff:ff/00:00:00:00:00/ef tag 0 dma 4096 in
>   res 51/04:08:f8:ff:ff/00:00:00:00:00/ef Emask 0x1 (device error)
>   ata1.00: status: { DRDY ERR }
>   ata1.00: error: { ABRT }
>   ata1.00: configured for UDMA/33
>   ata1: EH complete
>   ...

I'm surprised to see the above.  We do lots of dd to raw SATA drive
activity with a large variety of drives.  Both reads and writes and
we've never noticed this issue.

Does it happen if you are using 4k blocks with dd?

ie. We typically read / write the entire drive but using 4k blocks.

In fact a few months ago we specifically bought about 15 drives of
various sizes and manufacturers and verified that we could both read
and write all of the sectors of the drives.

Greg
--
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
