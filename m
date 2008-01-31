From: Simos Xenitellis <simos.lists@googlemail.com>
Subject: Re: Add one more HITACHI SATA disk to NCQ blacklist
Date: Thu, 31 Jan 2008 21:15:01 +0000
Message-ID: <1201814101.7165.16.camel@user-computer>
References: <1201797194.7165.13.camel@user-computer>
	 <311601c90801310907y1c016392i3ffc1d3a7d64853e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:22911 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756265AbYAaVPC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jan 2008 16:15:02 -0500
Received: by fg-out-1718.google.com with SMTP id e21so725660fga.17
        for <linux-ide@vger.kernel.org>; Thu, 31 Jan 2008 13:14:59 -0800 (PST)
In-Reply-To: <311601c90801310907y1c016392i3ffc1d3a7d64853e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>


On Thu, 2008-01-31 at 10:07 -0700, Eric D. Mudama wrote:
> I think the "spurious completions" issue was addressed in the
> 2.6.24-rc development series and is no longer an issue.
> 
> The two links you report as NCQ errors, the first is from 2.6.22
> (predating the fix) and the second is a SMART issue, not an NCQ issue.

Thanks Marc, Eric for the replies.

My original post with the error messages and the details of the disk is
at
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg12243.html

I'll have to test the latest version of the kernel to see if the problem
still persists.

Cheers,
Simos

> --eric
> 
> On Jan 31, 2008 9:33 AM, Simos Xenitellis <simos.lists@googlemail.com> wrote:
> > Hi,
> > The hard disk with
> >         model num: "HITACHI HTS541616J9SA00"
> >         model rev: "SB4IC7UP"
> >
> > is causing NCQ errors and should be blacklisted.
> > Currently the blacklist for Hitachi hard disks includes
> >
> >         { "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
> >         { "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
> > ...
> >         /* Blacklist entries taken from Silicon Image 3124/3132
> >            Windows driver .inf file - also several Linux problem reports */
> >         { "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
> >         { "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
> >         { "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
> >
> >
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=drivers/ata/libata-core.c;hb=HEAD
> >
> > The same hard disk causing NCQ errors to different users,
> > http://www.nabble.com/hdparm--B-1-and-Load_Cycle-on-Hitachi-HTS541616J9SA00-td14702758.html
> > https://bugs.edge.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/137470
> >
> >
> > Could you please add the entry
> >         { "HITACHI HTS541616J9SA00",    NULL,     ATA_HORKAGE_NONCQ, },
> >
> > Simos
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

