From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: GPT fdisk
Date: Fri, 16 Apr 2010 16:11:05 -0400
Message-ID: <k2v87f94c371004161311jee81bb51o7d23f4f18b9e36f4@mail.gmail.com>
References: <721544.69241.qm@web95511.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45237 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932317Ab0DPULG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Apr 2010 16:11:06 -0400
Received: by pwj9 with SMTP id 9so2316568pwj.19
        for <linux-ide@vger.kernel.org>; Fri, 16 Apr 2010 13:11:05 -0700 (PDT)
In-Reply-To: <721544.69241.qm@web95511.mail.in.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Keshav P.R." <skodabenz@rocketmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On Fri, Apr 16, 2010 at 2:06 PM, Keshav P.R. <skodabenz@rocketmail.com> wrote:
> Hi, I am Keshav from India. I read https://ata.wiki.kernel.org/index.php/ATA_4_KiB_sector_issues page which was very informative. I currently do not have any 4K sector drives but regarding GPT-4K sector support, check out this software http://rodsbooks.com/gdisk/ . This is currently the best GPT software (which is also cross-platform).
>
> I also have a question :- If I have a 4K sector internal HDD (without any jumpers etc. ie. the drive shows itself as 4K logical sector size), will there be any difference in behaviour of linux with these drives with respect to Legacy-IDE SATA mode and AHCI SATA mode options available in the BIOS ? Thank you.

Keshev,

To the best of my knowledge, no 4K logical sector drives exist yet and
they may not for some time (ie. years??), so I don't think your
question can be answered.

Specifically, I don't believe there are any drives regardless of
jumpers that enable a 4K presentation on the sata bus.  All bus
communications are based on 512 byte sectors.  And all addressing is
based on 512 byte sectors.

Thus they appear to the bios to be standard 512 byte sector drives and
the bios has no interaction issues.

The reality that a physical 4K sector is actually being manipulated on
the drive platters is a performance issue.  And thus it is important
to align filesystem 4K blocks with the drives physical 4K sectors to
avoid an excessive amount of read / modify / write activity within the
drive controller electronics.

Greg
