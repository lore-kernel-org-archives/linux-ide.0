From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: Re: libata EH running when switching VTs
Date: Tue, 25 Jan 2011 10:17:12 +0100
Message-ID: <201101251017.13164.toralf.foerster@gmx.de>
References: <201101221625.00775.toralf.foerster@gmx.de> <201101221831.09448.toralf.foerster@gmx.de> <4D3E2612.2060808@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D3E2612.2060808@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>, Jens Rutschmann <Jens.Rutschmann@gmx.info>
List-Id: linux-ide@vger.kernel.org


Robert Hancock wrote at 02:23:30
> On 01/22/2011 11:31 AM, Toralf F=C3=B6rster wrote:
> >>> I'm wondering why I get this in /var/log/messages w/ kernel 2.6.3=
7 when
> >>> I switch from VT7 (running xorg ) to VT12 (or 1 or 2 or another
> >>> number) and back:
> Curious, there seems to be no indication of why EH was triggered,
> doesn't seem to be have been due to an error. Does this also happen i=
n
> single-user mode or with minimal processes running? It's possible tha=
t
> userspace is triggering this somehow.

It happens only, when I switch to the VT7 _and_ X is running there.
It dos not happen when switching  only between straight consoles like f=
rom VT1=20
to VT2 or so.

BTW I Cc'ed Jens which have a similar problem with his ThinkPad T61:

>Hi Toralf,
>
>I saw lines similar to yours as well on my T61 during boot. It does no=
t occur=20
>when switching VTs.
>
>When I switch VTs as you described I get this in dmesg though:
>
>[  491.372673] ata1.00: configured for UDMA/133
>[  491.372677] ata1: EH complete
>[  491.680387] EXT4-fs (sda1): re-mounted. Opts: discard,commit=3D0
>[  491.683110] EXT4-fs (sda3): re-mounted. Opts: discard,commit=3D0
>
>This is with a vanilla 2.6.37

--=20
MfG/Kind regards
Toralf F=C3=B6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
