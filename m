From: Greg Oliver <oliver.greg@gmail.com>
Subject: Re: Either PMP issues, or SB700/800 Issues ??
Date: Sat, 18 Sep 2010 05:21:53 -0500
Message-ID: <AANLkTikA53t868U686WC_1ELexGAdyxfp4rCKHEWqXCx@mail.gmail.com>
References: <AANLkTikMLg2Uweeszw7pU9ZKWA0wTdLS5Y3NovOsb0fa@mail.gmail.com>
	<4C946B31.3060804@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64856 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab0IRKVz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Sep 2010 06:21:55 -0400
Received: by bwz11 with SMTP id 11so3382108bwz.19
        for <linux-ide@vger.kernel.org>; Sat, 18 Sep 2010 03:21:54 -0700 (PDT)
In-Reply-To: <4C946B31.3060804@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Sat, Sep 18, 2010 at 2:33 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 09/17/2010 07:05 PM, Greg Oliver wrote:
>> Does anyone know how far back I can take this working libahci/ahci
>> code? =C2=A0I would really like to get it running in centos - 2.6.19=
, but I
>> assume that's a no go.. =C2=A02.6.32 would be ideal, but I guess I c=
ould
>> live with 2.6.35 since there are patches floating around to make all
>> of my aforementioned stuff work.
>
> I don't recall any PMP or ahci related fix which could have cuased
> such behavior difference between 2.6.35 and 36 branch. =C2=A0Are you =
sure
> there aren't other factors which could be affecting the test result?
> Does going back to 2.6.35 reliably reproduce the problem? =C2=A0If so=
, can
> you please attach full kernel log including boot and the failure
> preferably with timestamps turned on? =C2=A0Also, please post the out=
put of
> "lspci -nn".

I got it squared away by building a 2.6.35-4 kernel with all of the
latest patches I could find.  It has been running good all day.
Here's the lspci in case you just want it.  I cannot reliably produce
it with 2.6.35 - like I said, it is 50/50..  But if it does boot, it
is guaranteed to start throwing the SCR errors, and the the frozen
errors I posted earlier.  The one thing that is definite is that when
it is not going to boot (it is connected to a external raid-5
enclosure with 15 ports), it will hard rest ata3.0, then 5, then 10,
then 15 and give the SCR error each time..  When it is going to
successfully boot, it hard resets ata1.0->ata1.15 in order with no
errors..  2.6.34 exhibits the 0,5,10,15 behavior every time, and
2.6.36 exhibits the 0->15 behavior every time..  Very strange..  Oh
well, it is working now and all of my userspace modules are happy
again.  I can run some tests if you like - just let me know.

00:14.3 ISA bridge [0601]: ATI Technologies Inc SB700/SB800 LPC host
controller [1002:439d]
00:00.0 Host bridge [0600]: Advanced Micro Devices [AMD] RS780 Host
Bridge Alternate [1022:9601]
00:01.0 PCI bridge [0604]: Advanced Micro Devices [AMD] RS780 PCI to
PCI bridge (int gfx) [1022:9602]
00:07.0 PCI bridge [0604]: Advanced Micro Devices [AMD] RS780 PCI to
PCI bridge (PCIE port 3) [1022:9607]
00:11.0 SATA controller [0106]: ATI Technologies Inc SB700/SB800 SATA
Controller [AHCI mode] [1002:4391]
00:12.0 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
OHCI0 Controller [1002:4397]
00:12.1 USB Controller [0c03]: ATI Technologies Inc SB700 USB OHCI1
Controller [1002:4398]
00:12.2 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
EHCI Controller [1002:4396]
00:13.0 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
OHCI0 Controller [1002:4397]
00:13.1 USB Controller [0c03]: ATI Technologies Inc SB700 USB OHCI1
Controller [1002:4398]
00:13.2 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
EHCI Controller [1002:4396]
00:14.0 SMBus [0c05]: ATI Technologies Inc SBx00 SMBus Controller
[1002:4385] (rev 3c)
00:14.1 IDE interface [0101]: ATI Technologies Inc SB700/SB800 IDE
Controller [1002:439c]
00:14.2 Audio device [0403]: ATI Technologies Inc SBx00 Azalia (Intel
HDA) [1002:4383]
00:14.3 ISA bridge [0601]: ATI Technologies Inc SB700/SB800 LPC host
controller [1002:439d]
00:14.4 PCI bridge [0604]: ATI Technologies Inc SBx00 PCI to PCI
Bridge [1002:4384]
00:14.5 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
OHCI2 Controller [1002:4399]
00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] K10 [Opteron,
Athlon64, Sempron] HyperTransport Configuration [1022:1200]
00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] K10 [Opteron,
Athlon64, Sempron] Address Map [1022:1201]
00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] K10 [Opteron,
Athlon64, Sempron] DRAM Controller [1022:1202]
00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] K10 [Opteron,
Athlon64, Sempron] Miscellaneous Control [1022:1203]
00:18.4 Host bridge [0600]: Advanced Micro Devices [AMD] K10 [Opteron,
Athlon64, Sempron] Link Control [1022:1204]
01:05.0 VGA compatible controller [0300]: ATI Technologies Inc RS880
[Radeon HD 4250] [1002:9715]
01:05.1 Audio device [0403]: ATI Technologies Inc RS880 Audio Device
[Radeon HD 4200] [1002:970f]
02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168] (rev
06

Thanks

-Greg
