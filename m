From: Daniel J Blueman <daniel@quora.org>
Subject: Re: [PATCH] Prevent interface errors with Seagate FreeAgent GoFlex
Date: Fri, 4 May 2012 10:44:51 +0800
Message-ID: <CAMVG2svuo+JhSDp87y9RJG91d5u9oq1=xSXQOchLg7pOHBzB=A@mail.gmail.com>
References: <1336058460-19924-1-git-send-email-daniel@quora.org>
	<4FA2F742.9010000@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FA2F742.9010000@fold.natur.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 4 May 2012 05:23, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz> wrote=
:
> Daniel J Blueman wrote:
>> When connected by the optional eSATAp cable, various interface error=
s
>> occur with my new external Seagate FreeAgent GoFlex (firmware 0110) =
until
>> the interface is forced to 1.5Gbps mode. Blacklist 3.0Gbps mode with=
 it
>> to avoid the error messages, delays and dataloss potential.
>>
[]
> =A0maybe I am talking nonsense but recently there were some fixes to =
bus speed posted here at
> linux-ide list from Lin Ming <ming.m.lin@intel.com>.
>
> In 3.4-rc5 it is already fixed so that if you unplug and re-plug a SA=
TA disk it can be detected
> at 3.0Gbps instead of just 1.5 (because previous unplug caused errors=
). An additional patch
> "Subject: [PATCH v2] libata: skip old error history when counting pro=
be trials"
> was just applied few hours ago some maybe you want to re-test? So is =
your blacklisting necessary?

This is an unrelated issue. The problems with the FreeAgent GoFlex
eSATAp optional cable are that it has buggy SATA2 support, and there
is a 100% correlation with errors regularly but infrequently (eg once
every few minutes) occurring at 3Gbps and no errors occurring at
1.5Gbps. The Seagate support forums tell the tale also (but largely on
Windows).

> When inspecting my "lspci -vvvxx" outputs I see that lots of my chips=
et devices in my SandyBridge
> laptop lifted up with the above mentioned patch from 2.5Gbps to 5Gbps
> (was about in a thread "Re: Hotplug borked after suspend/resume in Li=
nux-3.3 ?") which did not
> original tackle the error counter issue which broke the re-plugging.

Another patch will have correctly restored the PCIe 2.0 link training
registers, so this isn't connected.

> (I still do see problems with 3.4-rc5 on ExpressCard housed sata_sil2=
4 so that unplug of a disk
> and its re-plug results still only in 1.5Gbps instead of 3.0 Gbps, bu=
t if one waits a while
> so that the SCSI device is removed, then a re-plug catches up at 3 Gb=
ps. Probably have to apply
> the patch to null the error counter. ;-))

You're observing the ~5 second delay on unplug before the disk is
considered removed, to prevent dropping disks with intermittent
link/power/controller reset issues, so here 1.5Gbps link state is held
if unplugged for less than ~5 seconds.

Thanks!
  Daniel
--=20
Daniel J Blueman
