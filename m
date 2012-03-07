From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH v2 0/3] ahci: fix boot/resume COMRESET failures
Date: Wed, 7 Mar 2012 13:28:12 +0800
Message-ID: <CAF1ivSaDEfDFgF0hz3myjSc0BXhig1XGRa_uMOi=gtf2HTEMHg@mail.gmail.com>
References: <1329849524-23758-1-git-send-email-computersforpeace@gmail.com>
	<CAE5mzvgfsHD1Ku5saw+Cu7+vJAayx20=HfHfab1MrAwz3AtqJg@mail.gmail.com>
	<CAF1ivSZcGHQ-bnGasKghJ-_beDqgyZ_ug=m-7Ykr4xUphZeLqw@mail.gmail.com>
	<CAE5mzvgc60+_HOve+5wMsL7fo6jmM_sOB=_pTR1j23=RbP+uPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45188 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab2CGF2N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2012 00:28:13 -0500
In-Reply-To: <CAE5mzvgc60+_HOve+5wMsL7fo6jmM_sOB=_pTR1j23=RbP+uPw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cwillu <cwillu@cwillu.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Norbert Preining <preining@logic.at>, "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Matt <jackdachef@gmail.com>

On Mon, Mar 5, 2012 at 1:12 PM, cwillu <cwillu@cwillu.com> wrote:
> On Sun, Mar 4, 2012 at 6:58 PM, Lin Ming <ming.m.lin@intel.com> wrote=
:
>> On Fri, Mar 2, 2012 at 9:16 PM, cwillu <cwillu@cwillu.com> wrote:
>>> On Tue, Feb 21, 2012 at 12:38 PM, Brian Norris
>>> <computersforpeace@gmail.com> wrote:
>>>> This series addresses regression problems with
>>>>
>>>> =A0 =A0commit 7faa33da9b7add01db9f1ad92c6a5d9145e940a7
>>>> =A0 =A0ahci: start engine only during soft/hard resets
>>>
>>> I just spent the better part of last night tracking down the specif=
ic
>>> sources of the log entry I get when I disconnect my e-sata drive; o=
nce
>>> it disconnects, the port is dead until I reboot; no combination of
>>> anything I've been able to poke at in /sys or elsewhere gets it liv=
e
>>> again. =A0This starts with 3.3rc1, and turns out to still work fine=
 in
>>> 3.2.1. Any chance it's related?
>>>
>>> 3.3rc5, immediately after the unplug:
>>
>> Hi,
>>
>> I tested on my machine and it's fixed by below patch.
>> http://marc.info/?l=3Dlinux-kernel&m=3D132996405028746&w=3D2
>>
>> Would you please also try it?
>
> Building it now, and will be able to test in about 5 hours.

Hi,

How about the test result?

Regards,
Lin Ming

>
> After looking at the thread, I spent another couple hours on poking
> /sys, and did get the port to come back up and find the drive with th=
e
> following:
>
> echo on > /sys/devices/pci0000:00/0000:00:1f.2/ata5/power/control
> echo on > /sys/devices/pci0000:00/0000:00:1f.2/ata5/host4/power/contr=
ol
> echo '- - -' > /sys/devices/pci0000:00/0000:00:1f.2/ata5/host4/scsi_h=
ost/host4/scan
> --
