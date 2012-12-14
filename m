From: Michael Labriola <michael.d.labriola@gmail.com>
Subject: Re: v3.6 and up can't find HDD
Date: Fri, 14 Dec 2012 14:41:16 -0500
Message-ID: <CAOQxz3wTqGppkuN3EKcw94Vd2Yi1mNc_1DPJmwZcy7-xEWD9Uw@mail.gmail.com>
References: <CAOQxz3zHBtO=d1agOZQwfM4uVu7ysgAiNyoiziN6KUdu25=cQQ@mail.gmail.com>
	<50CB3CC1.6000300@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:60039 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202Ab2LNTlS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2012 14:41:18 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so747684wib.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2012 11:41:16 -0800 (PST)
In-Reply-To: <50CB3CC1.6000300@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Garrett <mjg@redhat.com>, linux-ide@vger.kernel.org, "Labriola, Michael" <mlabriol@gdeb.com>, jbolano@gdeb.com, "Dyke, Jayson" <jdyke@gdeb.com>, "Wehrly, Stuart" <swehrly@gdeb.com>

On Fri, Dec 14, 2012 at 9:50 AM, Aaron Lu <aaron.lu@intel.com> wrote:
> On 12/14/2012 06:32 AM, Michael Labriola wrote:
>> Jeff, Matthew,
>>
>> After updating from 3.3 to 3.6.8, the kernel fails to detect my hard
>> drive.  I'm using the included .config, which I migrated over from a
>> 3.3 kernel by just accepting all the defaults.  I bisected the problem
>> back to this commit:
>
> Hello Michael,
>
> I believe this is the same problem discussed here:
> https://bugzilla.kernel.org/show_bug.cgi?id=49151
>
> And the patch to fix this problem didn't reach Linus' tree yet, but is
> already queued in Jeff's NEXT branch:
> https://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commit;h=5416912af75de9cba5d1c75b99a7888b0bbbd2fb
>
> Please give it a test to see if it fixed your problem, thanks.
>
> Thanks,
> Aaron

Aaron,

I just got done testing Jeff's NEXT branch merged into v3.7.  It does
fix the traceback on the old dual Xeon, but both the old Xeon and my
newish Quad-core still fail to detect a HDD.  I get a bunch of ata
errors about retries and such, but nothing ever comes up.  The only
way to get my boxes to boot properly is to either compile with
CONFIG_ATA_ACPI turned off or with pata_acpi blacklisted...

Should udev even be loading pata_acpi on a recent system w/ only SATA devices?
