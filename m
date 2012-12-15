From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: v3.6 and up can't find HDD
Date: Sat, 15 Dec 2012 16:40:16 +0800
Message-ID: <50CC3770.3080106@intel.com>
References: <CAOQxz3zHBtO=d1agOZQwfM4uVu7ysgAiNyoiziN6KUdu25=cQQ@mail.gmail.com> <50CB3CC1.6000300@intel.com> <CAOQxz3wTqGppkuN3EKcw94Vd2Yi1mNc_1DPJmwZcy7-xEWD9Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24916 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab2LOIju (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Dec 2012 03:39:50 -0500
In-Reply-To: <CAOQxz3wTqGppkuN3EKcw94Vd2Yi1mNc_1DPJmwZcy7-xEWD9Uw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Labriola <michael.d.labriola@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Garrett <mjg@redhat.com>, linux-ide@vger.kernel.org, "Labriola, Michael" <mlabriol@gdeb.com>, jbolano@gdeb.com, "Dyke, Jayson" <jdyke@gdeb.com>, "Wehrly, Stuart" <swehrly@gdeb.com>

On 12/15/2012 03:41 AM, Michael Labriola wrote:
> On Fri, Dec 14, 2012 at 9:50 AM, Aaron Lu <aaron.lu@intel.com> wrote:
>> On 12/14/2012 06:32 AM, Michael Labriola wrote:
>>> Jeff, Matthew,
>>>
>>> After updating from 3.3 to 3.6.8, the kernel fails to detect my hard
>>> drive.  I'm using the included .config, which I migrated over from a
>>> 3.3 kernel by just accepting all the defaults.  I bisected the problem
>>> back to this commit:
>>
>> Hello Michael,
>>
>> I believe this is the same problem discussed here:
>> https://bugzilla.kernel.org/show_bug.cgi?id=49151
>>
>> And the patch to fix this problem didn't reach Linus' tree yet, but is
>> already queued in Jeff's NEXT branch:
>> https://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commit;h=5416912af75de9cba5d1c75b99a7888b0bbbd2fb
>>
>> Please give it a test to see if it fixed your problem, thanks.
>>
>> Thanks,
>> Aaron
> 
> Aaron,
> 
> I just got done testing Jeff's NEXT branch merged into v3.7.  It does
> fix the traceback on the old dual Xeon, but both the old Xeon and my
> newish Quad-core still fail to detect a HDD.  I get a bunch of ata
> errors about retries and such, but nothing ever comes up.  The only
> way to get my boxes to boot properly is to either compile with
> CONFIG_ATA_ACPI turned off or with pata_acpi blacklisted...
> 
> Should udev even be loading pata_acpi on a recent system w/ only SATA devices?

PATA_ACPI will only try to initialize IDE interface controllers, so did
you set the SATA controller to legacy IDE mode?

And for IDE controllers, PATA_ACPI should be the last module to try to
initialize the controller. See this bugzilla for more information on
this:
https://bugzilla.kernel.org/show_bug.cgi?id=48631

Thanks,
Aaron

> 

