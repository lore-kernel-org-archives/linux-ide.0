From: cwillu <cwillu@cwillu.com>
Subject: Re: [PATCH v2 0/3] ahci: fix boot/resume COMRESET failures
Date: Sun, 4 Mar 2012 23:12:36 -0600
Message-ID: <CAE5mzvgc60+_HOve+5wMsL7fo6jmM_sOB=_pTR1j23=RbP+uPw@mail.gmail.com>
References: <1329849524-23758-1-git-send-email-computersforpeace@gmail.com>
	<CAE5mzvgfsHD1Ku5saw+Cu7+vJAayx20=HfHfab1MrAwz3AtqJg@mail.gmail.com>
	<CAF1ivSZcGHQ-bnGasKghJ-_beDqgyZ_ug=m-7Ykr4xUphZeLqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54142 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab2CEFMg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Mar 2012 00:12:36 -0500
In-Reply-To: <CAF1ivSZcGHQ-bnGasKghJ-_beDqgyZ_ug=m-7Ykr4xUphZeLqw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Norbert Preining <preining@logic.at>, "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Matt <jackdachef@gmail.com>

On Sun, Mar 4, 2012 at 6:58 PM, Lin Ming <ming.m.lin@intel.com> wrote:
> On Fri, Mar 2, 2012 at 9:16 PM, cwillu <cwillu@cwillu.com> wrote:
>> On Tue, Feb 21, 2012 at 12:38 PM, Brian Norris
>> <computersforpeace@gmail.com> wrote:
>>> This series addresses regression problems with
>>>
>>> =C2=A0 =C2=A0commit 7faa33da9b7add01db9f1ad92c6a5d9145e940a7
>>> =C2=A0 =C2=A0ahci: start engine only during soft/hard resets
>>
>> I just spent the better part of last night tracking down the specifi=
c
>> sources of the log entry I get when I disconnect my e-sata drive; on=
ce
>> it disconnects, the port is dead until I reboot; no combination of
>> anything I've been able to poke at in /sys or elsewhere gets it live
>> again. =C2=A0This starts with 3.3rc1, and turns out to still work fi=
ne in
>> 3.2.1. Any chance it's related?
>>
>> 3.3rc5, immediately after the unplug:
>
> Hi,
>
> I tested on my machine and it's fixed by below patch.
> http://marc.info/?l=3Dlinux-kernel&m=3D132996405028746&w=3D2
>
> Would you please also try it?

Building it now, and will be able to test in about 5 hours.

After looking at the thread, I spent another couple hours on poking
/sys, and did get the port to come back up and find the drive with the
following:

echo on > /sys/devices/pci0000:00/0000:00:1f.2/ata5/power/control
echo on > /sys/devices/pci0000:00/0000:00:1f.2/ata5/host4/power/control
echo '- - -' > /sys/devices/pci0000:00/0000:00:1f.2/ata5/host4/scsi_hos=
t/host4/scan
