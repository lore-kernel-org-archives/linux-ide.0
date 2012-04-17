From: cwillu <cwillu@cwillu.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 15:05:09 -0600
Message-ID: <CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com>
References: <4F8DD4DC.4050503@teksavvy.com>
	<4F8DD708.8050502@teksavvy.com>
	<4F8DD834.5070000@teksavvy.com>
	<4F8DDA53.206@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49555 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab2DQVFK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 17:05:10 -0400
Received: by yhmm54 with SMTP id m54so3361070yhm.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2012 14:05:09 -0700 (PDT)
In-Reply-To: <4F8DDA53.206@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Apr 17, 2012 at 3:02 PM, Mark Lord <kernel@teksavvy.com> wrote:
> On 12-04-17 04:53 PM, Mark Lord wrote:
>> On 12-04-17 04:48 PM, Mark Lord wrote:
>>> On 12-04-17 04:38 PM, Mark Lord wrote:
>>>> Okay, so why isn't SATA hotplug working in linux-3.3.2 ?
>>>> I don't know when it stopped working, but it's a blooming pain in =
the sysadmin.
>>>>
>>>> I need to hotplug a SATA drive into an AHCI port,
>>>> preferably without having to reboot first.
>>>>
>>>> Is there a patch available already for this regression?
>>>
>>>
>>> Answering my own question, this patch appears to address the issue.
>>> I'll test and report back again shortly:
>>>
>>> =C2=A0 =C2=A0 http://patchwork.ozlabs.org/patch/146326/
>>>
>>> Odd that it's been sitting in various people's inboxes since 3.3-rc=
1
>>> and hasn't been pushed out yet.
>>
>> Ahh.. perhaps because it doesn't fix the problem I'm seeing here.
>>
>> Oh well, anyone else got a fix for this regression yet?
>> Even doing a rescan-scsi-bus doesn't work on the closed down ports.
>>
>> Basically, any unoccupied AHCI port is dead to the world
>> after a simple suspend/resume (RAM) cycle. =C2=A0On one of my machin=
es
>> I can hot unplug/replug the ExpressCard adapter to recover,
>> but that doesn't work so well for built-in SATA/eSATA ports.
>
>
> Mmm.. on my little Atom ZBOX systems, the patch linked above
> "Patchwork [v2] libata: disable runtime pm for hotpluggable port"
> _does_ appear to fix the issue.
>
> Maybe my notebook is suffering from the ExpressCard not being resumed=
 properly,
> which would be a PCI issue most likely.
>
> Anyway, one issue at a time: =C2=A0The "disable runtime pm" patch see=
ms to
> be the regression fix I'm looking for here so that I can use SATA hot=
plug
> after a suspend/resume.
>
> Why isn't this upstream as a regression fix yet?
>
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

echo on > /sys/devices/pci0000:00/0000:00:1f.2/ata5/power/control
echo on > /sys/devices/pci0000:00/0000:00:1f.2/ata5/host4/power/control
echo '- - -' > /sys/devices/pci0000:00/0000:00:1f.2/ata5/host4/scsi_hos=
t/host4/scan

Substituting the appropriate values to poke the right devices
