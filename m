From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Fwd: libata-pmp patch for 3.2.x and later for eSATA Port
 Multiplier Sil3726
Date: Thu, 22 Mar 2012 09:16:20 -0700
Message-ID: <CAMHSBOVD4wAtwAravVkDjyWV+Nwtuybt=yae=26PcGxxirw=Lg@mail.gmail.com>
References: <4F5ECD06.3000608@yahoo.co.jp>
	<4F5F7C4C.7080800@teksavvy.com>
	<4F662AFB.9050106@yahoo.co.jp>
	<CAMHSBOWg+rxxrVjf05r1tYDpW1S75XzdrLQ+U8TrjC9okRYtuA@mail.gmail.com>
	<4F6AAC37.7040907@yahoo.co.jp>
	<4F6B30D9.2070805@yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44389 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030750Ab2CVQQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2012 12:16:27 -0400
Received: by wejx9 with SMTP id x9so1967754wej.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2012 09:16:25 -0700 (PDT)
In-Reply-To: <4F6B30D9.2070805@yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "ANEZAKI, Akira" <fireblade1230@yahoo.co.jp>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Akira,

Now I see your problem. Indeed on ata7, ata10, we have a problem.
I notice however some messages I did not see before:
>> [ =A0 =A04.856382] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, =
6 ports, feat 0x1/0x9
>> [ =A0 =A04.858742] ata7.00: hard resetting link
>> [ =A0 14.843039] ata7.00: softreset failed (timeout)
>> [ =A0 17.836402] ata7.15: qc timeout (cmd 0xe4)
The later indicates that the PMP is stuck and the host can not read
its internal register.
Is it possible that the PMP in these 4 enclosures you are using have a
different firmware than the other ones?
=46irmware 1.0114 is available at:
http://www.siliconimage.com/support/searchresults.aspx?pid=3D26&cat=3D2=
3

=46rom the release notes:
"""- Fix SRST and initial two RegFIS Problem."""

Gwendal.

On Thu, Mar 22, 2012 at 7:02 AM, ANEZAKI, Akira
<fireblade1230@yahoo.co.jp> wrote:
> Hello Gwendal,
>
> I attached the dmesg logs of the PC that has 6 PMPs and 38 HDDs.
> ata5 and ata6 are SiI3124. 4 HDDs are connected to each port via PMP.
> These 8 HDDs require spin up.
> From ata7 to ata10 are SiI3132. 5 HDDs are connected to each port via
> PMP. And these 20 HDDs are always spin up while power is on. All HDDs
> connected to ata5 and ata6 are identified but slow with original 3.2.=
x
> driver. Some of HDDs connected to ata7,..., ata10 are not identified.
> So, I deleted ata5/6 messages from logs because logs become very long=
=2E
>
> --- 3.2.10 power cycle log ( not patched ) ---
> =A0 :
>> [ =A0 =A00.000000] Linux version 3.2.10-3.fc16.i686.PAE (mockbuild@x=
86-02.phx2.fedoraproject.org) (gcc version 4.6.2 20111027 (Red Hat 4.6.=
2-1) (GCC) ) #1 SMP Thu Mar 15 20:37:01 UTC 2012
> =A0 :
>> [ =A0 =A02.728377] ata7: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff0000 irq 17
>> [ =A0 =A02.728381] ata8: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff2000 irq 17
>> [ =A0 =A02.728385] ata9: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff4000 irq 17
>> [ =A0 =A02.728388] ata10: SATA max UDMA/100 host m128@0xfbfff400 por=
t 0xfbff6000 irq 17
> =A0 :
>> [ =A0 =A04.856020] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl=
 0)
>> [ =A0 =A04.856382] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, =
6 ports, feat 0x1/0x9
>> [ =A0 =A04.858742] ata7.00: hard resetting link
>> [ =A0 14.843039] ata7.00: softreset failed (timeout)
>> [ =A0 17.836402] ata7.15: qc timeout (cmd 0xe4)
>> [ =A0 17.836418] ata7.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0 17.836422] ata7.00: reset failed, giving up
>> [ =A0 17.836427] ata7.15: hard resetting link
>> [ =A0 19.963714] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 19.964339] ata7.00: hard resetting link
>> [ =A0 29.949543] ata7.00: softreset failed (timeout)
>> [ =A0 32.942886] ata7.15: qc timeout (cmd 0xe4)
>> [ =A0 32.942902] ata7.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0 32.942906] ata7.00: reset failed, giving up
>> [ =A0 32.942911] ata7.15: hard resetting link
>> [ =A0 35.070205] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 35.070883] ata7.00: hard resetting link
>> [ =A0 45.055960] ata7.00: softreset failed (timeout)
>> [ =A0 48.049443] ata7.15: qc timeout (cmd 0xe4)
>> [ =A0 48.049460] ata7.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0 48.049464] ata7.00: reset failed, giving up
>> [ =A0 48.049467] ata7.00: failed to recover link after 3 tries, disa=
bling
>> [ =A0 48.049472] ata7.15: hard resetting link
>> [ =A0 50.176735] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 50.481193] ata7.01: hard resetting link
>> [ =A0 50.884173] ata7.01: link resume succeeded after 1 retries
>> [ =A0 50.996894] ata7.01: softreset failed (SRST command error)
>> [ =A0 50.996972] ata7.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0 50.996978] ata7.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 60.459007] ata7.01: reset failed, giving up
>> [ =A0 60.459013] ata7.15: hard resetting link
>> [ =A0 62.575241] ata7.15: softreset failed (SRST command error)
>> [ =A0 62.575247] ata7.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0 70.436781] ata7.15: hard resetting link
>> [ =A0 72.553168] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 72.553176] ata7.15: PMP revalidation failed (errno=3D-19)
>> [ =A0 77.542029] ata7.15: hard resetting link
>> [ =A0 79.669334] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 79.973812] ata7.01: hard resetting link
>> [ =A0 80.376789] ata7.01: link resume succeeded after 1 retries
>> [ =A0 80.489507] ata7.01: softreset failed (SRST command error)
>> [ =A0 80.489553] ata7.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0 80.489559] ata7.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 89.951587] ata7.01: reset failed, giving up
>> [ =A0 89.951594] ata7.15: hard resetting link
>> [ =A0 92.067853] ata7.15: softreset failed (SRST command error)
>> [ =A0 92.067859] ata7.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0 99.929408] ata7.15: hard resetting link
>> [ =A0102.045764] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0102.045772] ata7.15: PMP revalidation failed (errno=3D-19)
>> [ =A0107.034803] ata7.15: hard resetting link
>> [ =A0109.161947] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0109.466423] ata7.01: hard resetting link
>> [ =A0109.869323] ata7.01: link resume succeeded after 1 retries
>> [ =A0110.091871] ata7.01: softreset failed (SRST command error)
>> [ =A0110.091987] ata7.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0110.091993] ata7.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0119.444232] ata7.01: reset failed, giving up
>> [ =A0119.444238] ata7.01: failed to recover link after 3 tries, disa=
bling
>> [ =A0119.444243] ata7.15: hard resetting link
>> [ =A0119.444247] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0121.593366] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0122.300882] ata7.01: link resume succeeded after 1 retries
>> [ =A0122.402786] ata7.02: hard resetting link
>> [ =A0122.805748] ata7.02: link resume succeeded after 1 retries
>> [ =A0123.028249] ata7.02: softreset failed (SRST command error)
>> [ =A0123.127975] ata7.02: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0123.127981] ata7.02: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0132.380480] ata7.02: reset failed, giving up
>> [ =A0132.380487] ata7.15: hard resetting link
>> [ =A0132.380492] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0134.529730] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0135.237187] ata7.01: link resume succeeded after 1 retries
>> [ =A0135.339040] ata7.02: hard resetting link
>> [ =A0135.742069] ata7.02: link resume succeeded after 1 retries
>> [ =A0135.854773] ata7.02: softreset failed (SRST command error)
>> [ =A0135.964517] ata7.02: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0135.964523] ata7.02: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0145.316864] ata7.02: reset failed, giving up
>> [ =A0145.316870] ata7.15: hard resetting link
>> [ =A0145.316874] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0147.466039] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0148.173548] ata7.01: link resume succeeded after 1 retries
>> [ =A0148.275398] ata7.02: hard resetting link
>> [ =A0148.678350] ata7.02: link resume succeeded after 1 retries
>> [ =A0148.791012] ata7.02: softreset failed (SRST command error)
>> [ =A0148.791027] ata7.02: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0148.791031] ata7.02: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0158.253189] ata7.02: reset failed, giving up
>> [ =A0158.253194] ata7.02: failed to recover link after 3 tries, disa=
bling
>> [ =A0158.253200] ata7.15: hard resetting link
>> [ =A0160.369472] ata7.15: softreset failed (SRST command error)
>> [ =A0160.369479] ata7.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0168.230986] ata7.15: hard resetting link
>> [ =A0170.347310] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0170.347320] ata7.15: PMP revalidation failed (errno=3D-19)
>> [ =A0175.336294] ata7.15: hard resetting link
>> [ =A0177.463536] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0178.171042] ata7.01: link resume succeeded after 1 retries
>> [ =A0178.675862] ata7.02: link resume succeeded after 1 retries
>> [ =A0178.777741] ata7.03: hard resetting link
>> [ =A0179.180751] ata7.03: link resume succeeded after 1 retries
>> [ =A0179.326643] ata7.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0179.326676] ata7.04: hard resetting link
>> [ =A0179.729532] ata7.04: link resume succeeded after 1 retries
>> [ =A0179.842249] ata7.04: softreset failed (SRST command error)
>> [ =A0179.842266] ata7.04: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0179.842271] ata7.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0189.304267] ata7.04: reset failed, giving up
>> [ =A0189.304274] ata7.15: hard resetting link
>> [ =A0191.420632] ata7.15: softreset failed (SRST command error)
>> [ =A0191.420638] ata7.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0199.282157] ata7.15: hard resetting link
>> [ =A0201.398523] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0201.398530] ata7.15: PMP revalidation failed (errno=3D-19)
>> [ =A0206.387708] ata7.15: hard resetting link
>> [ =A0208.514709] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0209.222203] ata7.01: link resume succeeded after 1 retries
>> [ =A0209.727084] ata7.02: link resume succeeded after 1 retries
>> [ =A0209.828920] ata7.03: hard resetting link
>> [ =A0210.231971] ata7.03: link resume succeeded after 1 retries
>> [ =A0210.366787] ata7.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0210.366845] ata7.04: hard resetting link
>> [ =A0210.769750] ata7.04: link resume succeeded after 1 retries
>> [ =A0210.882448] ata7.04: softreset failed (SRST command error)
>> [ =A0210.992171] ata7.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0210.992178] ata7.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0220.344472] ata7.04: reset failed, giving up
>> [ =A0220.344480] ata7.15: hard resetting link
>> [ =A0220.344485] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0222.493730] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0223.201162] ata7.01: link resume succeeded after 1 retries
>> [ =A0223.706048] ata7.02: link resume succeeded after 1 retries
>> [ =A0223.807935] ata7.03: hard resetting link
>> [ =A0224.210944] ata7.03: link resume succeeded after 1 retries
>> [ =A0224.357054] ata7.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0224.357092] ata7.04: hard resetting link
>> [ =A0224.759727] ata7.04: link resume succeeded after 1 retries
>> [ =A0224.872381] ata7.04: softreset failed (SRST command error)
>> [ =A0224.982171] ata7.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0224.982177] ata7.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0234.334455] ata7.04: reset failed, giving up
>> [ =A0234.334460] ata7.04: failed to recover link after 3 tries, disa=
bling
>> [ =A0234.334466] ata7.15: hard resetting link
>> [ =A0234.334470] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0236.483626] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0237.191170] ata7.01: link resume succeeded after 1 retries
>> [ =A0237.696026] ata7.02: link resume succeeded after 1 retries
>> [ =A0238.200931] ata7.04: link resume succeeded after 1 retries
>> [ =A0238.302815] ata7.03: hard resetting link
>> [ =A0238.705815] ata7.03: link resume succeeded after 1 retries
>> [ =A0238.851663] ata7.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0238.851697] ata7.05: hard resetting link
>> [ =A0239.156074] ata7.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0239.171748] ata7.03: ATA-7: WDC WD2500BB-22RDA0, 20.00K20, max =
UDMA/100
>> [ =A0239.171755] ata7.03: 488397168 sectors, multi 0: LBA48
>> [ =A0239.172994] ata7.03: configured for UDMA/100
>> [ =A0239.173063] ata7: EH complete
>> [ =A0241.301015] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
>> [ =A0241.301401] ata8.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 =
ports, feat 0x1/0x9
>> [ =A0241.304393] ata8.00: hard resetting link
>> [ =A0251.288864] ata8.00: softreset failed (timeout)
>> [ =A0254.282482] ata8.15: qc timeout (cmd 0xe4)
>> [ =A0254.282498] ata8.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0254.282502] ata8.00: reset failed, giving up
>> [ =A0254.282507] ata8.15: hard resetting link
>> [ =A0256.308766] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0256.309087] ata8.00: hard resetting link
>> [ =A0266.294599] ata8.00: softreset failed (timeout)
>> [ =A0269.287996] ata8.15: qc timeout (cmd 0xe4)
>> [ =A0269.288012] ata8.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0269.288016] ata8.00: reset failed, giving up
>> [ =A0269.288021] ata8.15: hard resetting link
>> [ =A0271.415256] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0271.415676] ata8.00: hard resetting link
>> [ =A0281.400112] ata8.00: softreset failed (timeout)
>> [ =A0284.393557] ata8.15: qc timeout (cmd 0xe4)
>> [ =A0284.393574] ata8.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0284.393578] ata8.00: reset failed, giving up
>> [ =A0284.393581] ata8.00: failed to recover link after 3 tries, disa=
bling
>> [ =A0284.393586] ata8.15: hard resetting link
>> [ =A0286.520673] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0286.825285] ata8.01: hard resetting link
>> [ =A0287.228273] ata8.01: link resume succeeded after 1 retries
>> [ =A0287.340950] ata8.01: softreset failed (SRST command error)
>> [ =A0287.341009] ata8.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0287.341014] ata8.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0296.802999] ata8.01: reset failed, giving up
>> [ =A0296.803006] ata8.15: hard resetting link
>> [ =A0298.919298] ata8.15: softreset failed (SRST command error)
>> [ =A0298.919304] ata8.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0306.780857] ata8.15: hard resetting link
>> [ =A0308.897206] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0308.897213] ata8.15: PMP revalidation failed (errno=3D-19)
>> [ =A0313.886328] ata8.15: hard resetting link
>> [ =A0316.013386] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0316.317852] ata8.01: hard resetting link
>> [ =A0316.720861] ata8.01: link resume succeeded after 1 retries
>> [ =A0316.833555] ata8.01: softreset failed (SRST command error)
>> [ =A0316.943305] ata8.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0316.943310] ata8.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0326.295601] ata8.01: reset failed, giving up
>> [ =A0326.295609] ata8.15: hard resetting link
>> [ =A0326.295614] ata8: controller in dubious state, performing PORT_=
RST
>> [ =A0328.444830] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0328.749267] ata8.01: hard resetting link
>> [ =A0329.152302] ata8.01: link resume succeeded after 1 retries
>> [ =A0329.264987] ata8.01: softreset failed (SRST command error)
>> [ =A0329.374746] ata8.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0329.374751] ata8.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0338.727034] ata8.01: reset failed, giving up
>> [ =A0338.727039] ata8.01: failed to recover link after 3 tries, disa=
bling
>> [ =A0338.727045] ata8.15: hard resetting link
>> [ =A0338.727048] ata8: controller in dubious state, performing PORT_=
RST
>> [ =A0340.876275] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0341.583749] ata8.01: link resume succeeded after 1 retries
>> [ =A0341.685751] ata8.02: hard resetting link
>> [ =A0342.088629] ata8.02: link resume succeeded after 1 retries
>> [ =A0342.223408] ata8.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0342.223441] ata8.03: hard resetting link
>> [ =A0342.626462] ata8.03: link resume succeeded after 1 retries
>> [ =A0342.761370] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0342.761404] ata8.04: hard resetting link
>> [ =A0343.076391] ata8.04: softreset failed (SRST command error)
>> [ =A0343.076449] ata8.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0343.076455] ata8.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0352.738995] ata8.04: reset failed, giving up
>> [ =A0352.739001] ata8.15: hard resetting link
>> [ =A0354.855321] ata8.15: softreset failed (SRST command error)
>> [ =A0354.855327] ata8.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0362.716861] ata8.15: hard resetting link
>> [ =A0364.834209] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0364.834217] ata8.15: PMP revalidation failed (errno=3D-19)
>> [ =A0369.823118] ata8.15: hard resetting link
>> [ =A0371.950402] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0372.657852] ata8.01: link resume succeeded after 1 retries
>> [ =A0372.759682] ata8.02: hard resetting link
>> [ =A0373.162733] ata8.02: link resume succeeded after 1 retries
>> [ =A0373.297762] ata8.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0373.297795] ata8.03: hard resetting link
>> [ =A0373.700539] ata8.03: link resume succeeded after 1 retries
>> [ =A0373.835515] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0373.835549] ata8.04: hard resetting link
>> [ =A0374.150481] ata8.04: softreset failed (SRST command error)
>> [ =A0374.150528] ata8.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0374.150533] ata8.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0383.813191] ata8.04: reset failed, giving up
>> [ =A0383.813198] ata8.15: hard resetting link
>> [ =A0385.929331] ata8.15: softreset failed (SRST command error)
>> [ =A0385.929337] ata8.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0393.790968] ata8.15: hard resetting link
>> [ =A0395.907164] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0395.907172] ata8.15: PMP revalidation failed (errno=3D-19)
>> [ =A0400.896325] ata8.15: hard resetting link
>> [ =A0403.023517] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0403.731005] ata8.01: link resume succeeded after 1 retries
>> [ =A0403.832842] ata8.02: hard resetting link
>> [ =A0404.235865] ata8.02: link resume succeeded after 1 retries
>> [ =A0404.370794] ata8.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0404.370849] ata8.03: hard resetting link
>> [ =A0404.773633] ata8.03: link resume succeeded after 1 retries
>> [ =A0404.908669] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0404.908703] ata8.04: hard resetting link
>> [ =A0405.223579] ata8.04: softreset failed (SRST command error)
>> [ =A0405.333350] ata8.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0405.333356] ata8.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0414.886197] ata8.04: reset failed, giving up
>> [ =A0414.886202] ata8.04: failed to recover link after 3 tries, disa=
bling
>> [ =A0414.886208] ata8.15: hard resetting link
>> [ =A0414.886211] ata8: controller in dubious state, performing PORT_=
RST
>> [ =A0417.035450] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0417.742943] ata8.01: link resume succeeded after 1 retries
>> [ =A0418.247823] ata8.04: link resume succeeded after 1 retries
>> [ =A0418.349670] ata8.02: hard resetting link
>> [ =A0418.752703] ata8.02: link resume succeeded after 1 retries
>> [ =A0418.887633] ata8.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0418.887669] ata8.03: hard resetting link
>> [ =A0419.290512] ata8.03: link resume succeeded after 1 retries
>> [ =A0419.425418] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0419.425451] ata8.05: hard resetting link
>> [ =A0419.729769] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0419.774605] ata8.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0419.774611] ata8.02: 625142448 sectors, multi 0: LBA48
>> [ =A0419.774617] ata8.02: applying bridge limits
>> [ =A0419.832687] ata8.02: configured for UDMA/100
>> [ =A0419.873220] ata8.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0419.873226] ata8.03: 625142448 sectors, multi 0: LBA48
>> [ =A0419.931259] ata8.03: configured for UDMA/100
>> [ =A0419.931327] ata8: EH complete
>> [ =A0422.060283] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
>> [ =A0422.060785] ata9.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 =
ports, feat 0x1/0x9
>> [ =A0422.064165] ata9.00: hard resetting link
>> [ =A0432.051137] ata9.00: softreset failed (timeout)
>> [ =A0435.044561] ata9.15: qc timeout (cmd 0xe4)
>> [ =A0435.044578] ata9.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0435.044582] ata9.00: reset failed, giving up
>> [ =A0435.044587] ata9.15: hard resetting link
>> [ =A0437.171811] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0437.172249] ata9.00: hard resetting link
>> [ =A0447.156648] ata9.00: softreset failed (timeout)
>> [ =A0450.149961] ata9.15: qc timeout (cmd 0xe4)
>> [ =A0450.149979] ata9.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0450.149985] ata9.00: reset failed, giving up
>> [ =A0450.149992] ata9.15: hard resetting link
>> [ =A0452.277364] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0452.277711] ata9.00: hard resetting link
>> [ =A0462.262159] ata9.00: softreset failed (timeout)
>> [ =A0465.255619] ata9.15: qc timeout (cmd 0xe4)
>> [ =A0465.255635] ata9.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0465.255639] ata9.00: reset failed, giving up
>> [ =A0465.255643] ata9.00: failed to recover link after 3 tries, disa=
bling
>> [ =A0465.255648] ata9.15: hard resetting link
>> [ =A0467.382834] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0467.688287] ata9.01: hard resetting link
>> [ =A0468.091305] ata9.01: link resume succeeded after 1 retries
>> [ =A0468.226246] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0468.226301] ata9.02: hard resetting link
>> [ =A0468.629118] ata9.02: link resume succeeded after 1 retries
>> [ =A0468.764014] ata9.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0468.764047] ata9.03: hard resetting link
>> [ =A0469.166941] ata9.03: link resume succeeded after 1 retries
>> [ =A0469.301843] ata9.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0469.301877] ata9.04: hard resetting link
>> [ =A0469.704728] ata9.04: link resume succeeded after 1 retries
>> [ =A0469.927155] ata9.04: softreset failed (SRST command error)
>> [ =A0469.927269] ata9.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0469.927275] ata9.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0479.279534] ata9.04: reset failed, giving up
>> [ =A0479.279540] ata9.15: hard resetting link
>> [ =A0479.279544] ata9: controller in dubious state, performing PORT_=
RST
>> [ =A0481.428685] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0481.733166] ata9.01: hard resetting link
>> [ =A0482.136168] ata9.01: link resume succeeded after 1 retries
>> [ =A0482.271032] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0482.271066] ata9.02: hard resetting link
>> [ =A0482.673977] ata9.02: link resume succeeded after 1 retries
>> [ =A0482.808905] ata9.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0482.808938] ata9.03: hard resetting link
>> [ =A0483.211797] ata9.03: link resume succeeded after 1 retries
>> [ =A0483.346679] ata9.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0483.346735] ata9.04: hard resetting link
>> [ =A0483.749592] ata9.04: link resume succeeded after 1 retries
>> [ =A0483.862225] ata9.04: softreset failed (SRST command error)
>> [ =A0483.862301] ata9.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0483.862306] ata9.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0493.324567] ata9.04: reset failed, giving up
>> [ =A0493.324574] ata9.15: hard resetting link
>> [ =A0495.440632] ata9.15: softreset failed (SRST command error)
>> [ =A0495.440638] ata9.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0503.302208] ata9.15: hard resetting link
>> [ =A0505.418541] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0505.418549] ata9.15: PMP revalidation failed (errno=3D-19)
>> [ =A0510.407473] ata9.15: hard resetting link
>> [ =A0512.534721] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0512.839192] ata9.01: hard resetting link
>> [ =A0513.242191] ata9.01: link resume succeeded after 1 retries
>> [ =A0513.377113] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0513.377168] ata9.02: hard resetting link
>> [ =A0513.779948] ata9.02: link resume succeeded after 1 retries
>> [ =A0513.914918] ata9.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0513.914951] ata9.03: hard resetting link
>> [ =A0514.317810] ata9.03: link resume succeeded after 1 retries
>> [ =A0514.452725] ata9.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0514.452759] ata9.04: hard resetting link
>> [ =A0514.855616] ata9.04: link resume succeeded after 1 retries
>> [ =A0514.968324] ata9.04: softreset failed (SRST command error)
>> [ =A0515.078062] ata9.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0515.078068] ata9.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0524.430341] ata9.04: reset failed, giving up
>> [ =A0524.430346] ata9.04: failed to recover link after 3 tries, disa=
bling
>> [ =A0524.430352] ata9.15: hard resetting link
>> [ =A0524.430355] ata9: controller in dubious state, performing PORT_=
RST
>> [ =A0526.579506] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0527.287026] ata9.04: link resume succeeded after 1 retries
>> [ =A0527.388982] ata9.01: hard resetting link
>> [ =A0527.791958] ata9.01: link resume succeeded after 1 retries
>> [ =A0527.926873] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0527.926906] ata9.02: hard resetting link
>> [ =A0528.329747] ata9.02: link resume succeeded after 1 retries
>> [ =A0528.464667] ata9.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0528.464723] ata9.03: hard resetting link
>> [ =A0528.867555] ata9.03: link resume succeeded after 1 retries
>> [ =A0529.002500] ata9.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0529.002537] ata9.05: hard resetting link
>> [ =A0529.306850] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0529.349846] ata9.01: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0529.349852] ata9.01: 625142448 sectors, multi 0: LBA48
>> [ =A0529.349858] ata9.01: applying bridge limits
>> [ =A0529.407928] ata9.01: configured for UDMA/100
>> [ =A0529.454790] ata9.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0529.454796] ata9.02: 625142448 sectors, multi 0: LBA48
>> [ =A0529.454802] ata9.02: applying bridge limits
>> [ =A0529.512845] ata9.02: configured for UDMA/100
>> [ =A0529.557037] ata9.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0529.557043] ata9.03: 625142448 sectors, multi 0: LBA48
>> [ =A0529.557049] ata9.03: applying bridge limits
>> [ =A0529.615208] ata9.03: configured for UDMA/100
>> [ =A0529.615276] ata9: EH complete
>> [ =A0531.745132] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl =
0)
>> [ =A0531.745518] ata10.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6=
 ports, feat 0x1/0x9
>> [ =A0531.748378] ata10.00: hard resetting link
>> [ =A0541.732981] ata10.00: softreset failed (timeout)
>> [ =A0544.726484] ata10.15: qc timeout (cmd 0xe4)
>> [ =A0544.726500] ata10.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0544.726504] ata10.00: reset failed, giving up
>> [ =A0544.726509] ata10.15: hard resetting link
>> [ =A0546.853639] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
>> [ =A0546.854296] ata10.00: hard resetting link
>> [ =A0556.839495] ata10.00: softreset failed (timeout)
>> [ =A0559.832859] ata10.15: qc timeout (cmd 0xe4)
>> [ =A0559.832875] ata10.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0559.832879] ata10.00: reset failed, giving up
>> [ =A0559.832884] ata10.15: hard resetting link
>> [ =A0561.960149] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
>> [ =A0561.960603] ata10.00: hard resetting link
>> [ =A0571.944967] ata10.00: softreset failed (timeout)
>> [ =A0574.938480] ata10.15: qc timeout (cmd 0xe4)
>> [ =A0574.938496] ata10.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0574.938500] ata10.00: reset failed, giving up
>> [ =A0574.938504] ata10.00: failed to recover link after 3 tries, dis=
abling
>> [ =A0574.938509] ata10.15: hard resetting link
>> [ =A0577.065685] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
>> [ =A0577.370126] ata10.01: hard resetting link
>> [ =A0577.773138] ata10.01: link resume succeeded after 1 retries
>> [ =A0577.908044] ata10.01: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0577.908100] ata10.02: hard resetting link
>> [ =A0578.310944] ata10.02: link resume succeeded after 1 retries
>> [ =A0578.445975] ata10.02: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0578.446011] ata10.03: hard resetting link
>> [ =A0578.848752] ata10.03: link resume succeeded after 1 retries
>> [ =A0578.983663] ata10.03: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0578.983696] ata10.04: hard resetting link
>> [ =A0579.386604] ata10.04: link resume succeeded after 1 retries
>> [ =A0579.521504] ata10.04: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0579.521537] ata10.05: hard resetting link
>> [ =A0579.825806] ata10.05: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 320)
>> [ =A0579.867413] ata10.01: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0579.867419] ata10.01: 625142448 sectors, multi 0: LBA48
>> [ =A0579.925564] ata10.01: configured for UDMA/100
>> [ =A0579.976084] ata10.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0579.976093] ata10.02: 625142448 sectors, multi 0: LBA48
>> [ =A0580.034256] ata10.02: configured for UDMA/100
>> [ =A0580.079872] ata10.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0580.079880] ata10.03: 625142448 sectors, multi 0: LBA48
>> [ =A0580.138089] ata10.03: configured for UDMA/100
>> [ =A0580.181012] ata10.04: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0580.181018] ata10.04: 625142448 sectors, multi 0: LBA48
>> [ =A0580.238994] ata10.04: configured for UDMA/100
>> [ =A0580.239060] ata10: EH complete
> =A0 :
>> [ =A0673.269722] systemd[1]: Startup finished in 2s 215ms 631us (ker=
nel) + 9min 41s 253ms 808us (initrd) + 1min 31s 95ms 965us (userspace) =
=3D 11min 14s 565ms 404us.
> --------
>
> --- 3.2.10 warm reset log ( not patched ) ---
> =A0 :
>> [ =A0 =A00.000000] Linux version 3.2.10-3.fc16.i686.PAE (mockbuild@x=
86-02.phx2.fedoraproject.org) (gcc version 4.6.2 20111027 (Red Hat 4.6.=
2-1) (GCC) ) #1 SMP Thu Mar 15 20:37:01 UTC 2012
> =A0 :
>> [ =A0 =A02.728305] ata7: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff0000 irq 17
>> [ =A0 =A02.728309] ata8: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff2000 irq 17
>> [ =A0 =A02.728313] ata9: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff4000 irq 17
>> [ =A0 =A02.728317] ata10: SATA max UDMA/100 host m128@0xfbfff400 por=
t 0xfbff6000 irq 17
> =A0 :
>> [ =A0 =A04.857114] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl=
 0)
>> [ =A0 =A04.857429] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, =
6 ports, feat 0x1/0x9
>> [ =A0 =A04.860366] ata7.00: hard resetting link
>> [ =A0 14.847053] ata7.00: softreset failed (timeout)
>> [ =A0 17.840588] ata7.15: qc timeout (cmd 0xe4)
>> [ =A0 17.840605] ata7.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0 17.840609] ata7.00: reset failed, giving up
>> [ =A0 17.840614] ata7.15: hard resetting link
>> [ =A0 19.967586] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 19.967961] ata7.00: hard resetting link
>> [ =A0 29.952563] ata7.00: softreset failed (timeout)
>> [ =A0 32.946005] ata7.15: qc timeout (cmd 0xe4)
>> [ =A0 32.946021] ata7.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0 32.946025] ata7.00: reset failed, giving up
>> [ =A0 32.946030] ata7.15: hard resetting link
>> [ =A0 35.073261] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 35.073643] ata7.00: hard resetting link
>> [ =A0 45.058071] ata7.00: softreset failed (timeout)
>> [ =A0 48.051483] ata7.15: qc timeout (cmd 0xe4)
>> [ =A0 48.051499] ata7.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0 48.051503] ata7.00: reset failed, giving up
>> [ =A0 48.051507] ata7.00: failed to recover link after 3 tries, disa=
bling
>> [ =A0 48.051512] ata7.15: hard resetting link
>> [ =A0 50.178736] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 50.483203] ata7.01: hard resetting link
>> [ =A0 50.886209] ata7.01: link resume succeeded after 1 retries
>> [ =A0 51.108651] ata7.01: softreset failed (SRST command error)
>> [ =A0 51.108762] ata7.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0 51.108768] ata7.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 60.460919] ata7.01: reset failed, giving up
>> [ =A0 60.460925] ata7.15: hard resetting link
>> [ =A0 60.460929] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0 62.610196] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 62.914676] ata7.01: hard resetting link
>> [ =A0 63.317656] ata7.01: link resume succeeded after 1 retries
>> [ =A0 63.540078] ata7.01: softreset failed (SRST command error)
>> [ =A0 63.540189] ata7.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0 63.540195] ata7.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 72.892375] ata7.01: reset failed, giving up
>> [ =A0 72.892381] ata7.15: hard resetting link
>> [ =A0 72.892385] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0 75.041637] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 75.346105] ata7.01: hard resetting link
>> [ =A0 75.749094] ata7.01: link resume succeeded after 1 retries
>> [ =A0 75.861794] ata7.01: softreset failed (SRST command error)
>> [ =A0 75.971535] ata7.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0 75.971541] ata7.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 85.323801] ata7.01: reset failed, giving up
>> [ =A0 85.323806] ata7.01: failed to recover link after 3 tries, disa=
bling
>> [ =A0 85.323812] ata7.15: hard resetting link
>> [ =A0 85.323815] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0 87.473057] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 88.180573] ata7.01: link resume succeeded after 1 retries
>> [ =A0 88.282411] ata7.02: hard resetting link
>> [ =A0 88.685408] ata7.02: link resume succeeded after 1 retries
>> [ =A0 88.907856] ata7.02: softreset failed (SRST command error)
>> [ =A0 89.017611] ata7.02: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0 89.017617] ata7.02: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 98.260156] ata7.02: reset failed, giving up
>> [ =A0 98.260162] ata7.15: hard resetting link
>> [ =A0 98.260166] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0100.409394] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0101.116820] ata7.01: link resume succeeded after 1 retries
>> [ =A0101.218781] ata7.02: hard resetting link
>> [ =A0101.621721] ata7.02: link resume succeeded after 1 retries
>> [ =A0101.734438] ata7.02: softreset failed (SRST command error)
>> [ =A0101.734497] ata7.02: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0101.734503] ata7.02: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0111.196658] ata7.02: reset failed, giving up
>> [ =A0111.196665] ata7.15: hard resetting link
>> [ =A0113.312791] ata7.15: softreset failed (SRST command error)
>> [ =A0113.312796] ata7.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0121.174424] ata7.15: hard resetting link
>> [ =A0123.290728] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0123.290735] ata7.15: PMP revalidation failed (errno=3D-19)
>> [ =A0128.279611] ata7.15: hard resetting link
>> [ =A0130.406891] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0131.114346] ata7.01: link resume succeeded after 1 retries
>> [ =A0131.216223] ata7.02: hard resetting link
>> [ =A0131.619242] ata7.02: link resume succeeded after 1 retries
>> [ =A0131.841674] ata7.02: softreset failed (SRST command error)
>> [ =A0131.841789] ata7.02: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0131.841795] ata7.02: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0141.194111] ata7.02: reset failed, giving up
>> [ =A0141.194116] ata7.02: failed to recover link after 3 tries, disa=
bling
>> [ =A0141.194122] ata7.15: hard resetting link
>> [ =A0141.194126] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0143.343218] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0144.050671] ata7.01: link resume succeeded after 1 retries
>> [ =A0144.555590] ata7.02: link resume succeeded after 1 retries
>> [ =A0144.657379] ata7.03: hard resetting link
>> [ =A0145.060433] ata7.03: link resume succeeded after 1 retries
>> [ =A0145.206413] ata7.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0145.206446] ata7.04: hard resetting link
>> [ =A0145.609232] ata7.04: link resume succeeded after 1 retries
>> [ =A0145.721921] ata7.04: softreset failed (SRST command error)
>> [ =A0145.721997] ata7.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0145.722003] ata7.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0155.184070] ata7.04: reset failed, giving up
>> [ =A0155.184076] ata7.15: hard resetting link
>> [ =A0157.300201] ata7.15: softreset failed (SRST command error)
>> [ =A0157.300206] ata7.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0165.161929] ata7.15: hard resetting link
>> [ =A0167.278086] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0167.278094] ata7.15: PMP revalidation failed (errno=3D-19)
>> [ =A0172.267085] ata7.15: hard resetting link
>> [ =A0174.394357] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0175.101835] ata7.01: link resume succeeded after 1 retries
>> [ =A0175.606735] ata7.02: link resume succeeded after 1 retries
>> [ =A0175.708593] ata7.03: hard resetting link
>> [ =A0176.111610] ata7.03: link resume succeeded after 1 retries
>> [ =A0176.257481] ata7.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0176.257514] ata7.04: hard resetting link
>> [ =A0176.660366] ata7.04: link resume succeeded after 1 retries
>> [ =A0176.882825] ata7.04: softreset failed (SRST command error)
>> [ =A0176.882943] ata7.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0176.882948] ata7.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0186.235215] ata7.04: reset failed, giving up
>> [ =A0186.235221] ata7.15: hard resetting link
>> [ =A0186.235225] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0188.384387] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0189.091824] ata7.01: link resume succeeded after 1 retries
>> [ =A0189.596721] ata7.02: link resume succeeded after 1 retries
>> [ =A0189.698575] ata7.03: hard resetting link
>> [ =A0190.101579] ata7.03: link resume succeeded after 1 retries
>> [ =A0190.236540] ata7.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0190.236573] ata7.04: hard resetting link
>> [ =A0190.639411] ata7.04: link resume succeeded after 1 retries
>> [ =A0190.861835] ata7.04: softreset failed (SRST command error)
>> [ =A0190.861952] ata7.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0190.861958] ata7.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0200.214230] ata7.04: reset failed, giving up
>> [ =A0200.214235] ata7.04: failed to recover link after 3 tries, disa=
bling
>> [ =A0200.214241] ata7.15: hard resetting link
>> [ =A0200.214245] ata7: controller in dubious state, performing PORT_=
RST
>> [ =A0202.363386] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0203.070830] ata7.01: link resume succeeded after 1 retries
>> [ =A0203.575726] ata7.02: link resume succeeded after 1 retries
>> [ =A0204.080613] ata7.04: link resume succeeded after 1 retries
>> [ =A0204.182486] ata7.03: hard resetting link
>> [ =A0204.585489] ata7.03: link resume succeeded after 1 retries
>> [ =A0204.731415] ata7.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0204.731470] ata7.05: hard resetting link
>> [ =A0205.035777] ata7.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0205.048761] ata7.03: ATA-7: WDC WD2500BB-22RDA0, 20.00K20, max =
UDMA/100
>> [ =A0205.048767] ata7.03: 488397168 sectors, multi 0: LBA48
>> [ =A0205.050024] ata7.03: configured for UDMA/100
>> [ =A0205.050091] ata7: EH complete
>> [ =A0207.178745] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
>> [ =A0207.179371] ata8.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 =
ports, feat 0x1/0x9
>> [ =A0207.182429] ata8.00: hard resetting link
>> [ =A0217.168525] ata8.00: softreset failed (timeout)
>> [ =A0220.161929] ata8.15: qc timeout (cmd 0xe4)
>> [ =A0220.161945] ata8.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0220.161949] ata8.00: reset failed, giving up
>> [ =A0220.161954] ata8.15: hard resetting link
>> [ =A0222.289193] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0222.289669] ata8.00: hard resetting link
>> [ =A0232.274042] ata8.00: softreset failed (timeout)
>> [ =A0235.267413] ata8.15: qc timeout (cmd 0xe4)
>> [ =A0235.267430] ata8.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0235.267434] ata8.00: reset failed, giving up
>> [ =A0235.267439] ata8.15: hard resetting link
>> [ =A0237.394721] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0237.395117] ata8.00: hard resetting link
>> [ =A0247.381547] ata8.00: softreset failed (timeout)
>> [ =A0250.375186] ata8.15: qc timeout (cmd 0xe4)
>> [ =A0250.375202] ata8.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0250.375206] ata8.00: reset failed, giving up
>> [ =A0250.375210] ata8.00: failed to recover link after 3 tries, disa=
bling
>> [ =A0250.375215] ata8.15: hard resetting link
>> [ =A0252.502205] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0252.806698] ata8.01: hard resetting link
>> [ =A0253.209687] ata8.01: link resume succeeded after 1 retries
>> [ =A0253.322366] ata8.01: softreset failed (SRST command error)
>> [ =A0253.432126] ata8.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0253.432132] ata8.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0262.784386] ata8.01: reset failed, giving up
>> [ =A0262.784393] ata8.15: hard resetting link
>> [ =A0262.784396] ata8: controller in dubious state, performing PORT_=
RST
>> [ =A0264.933544] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0265.238130] ata8.01: hard resetting link
>> [ =A0265.641134] ata8.01: link resume succeeded after 1 retries
>> [ =A0265.863530] ata8.01: softreset failed (SRST command error)
>> [ =A0265.863649] ata8.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0265.863656] ata8.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0275.215940] ata8.01: reset failed, giving up
>> [ =A0275.215947] ata8.15: hard resetting link
>> [ =A0275.215950] ata8: controller in dubious state, performing PORT_=
RST
>> [ =A0277.365109] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0277.669544] ata8.01: hard resetting link
>> [ =A0278.072561] ata8.01: link resume succeeded after 1 retries
>> [ =A0278.185268] ata8.01: softreset failed (SRST command error)
>> [ =A0278.185345] ata8.01: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0278.185350] ata8.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0287.647375] ata8.01: reset failed, giving up
>> [ =A0287.647380] ata8.01: failed to recover link after 3 tries, disa=
bling
>> [ =A0287.647386] ata8.15: hard resetting link
>> [ =A0289.763635] ata8.15: softreset failed (SRST command error)
>> [ =A0289.763641] ata8.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0297.625370] ata8.15: hard resetting link
>> [ =A0299.741510] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0299.741517] ata8.15: PMP revalidation failed (errno=3D-19)
>> [ =A0304.730436] ata8.15: hard resetting link
>> [ =A0306.857730] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0307.565198] ata8.01: link resume succeeded after 1 retries
>> [ =A0307.667104] ata8.02: hard resetting link
>> [ =A0308.070064] ata8.02: link resume succeeded after 1 retries
>> [ =A0308.204919] ata8.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0308.204959] ata8.03: hard resetting link
>> [ =A0308.607881] ata8.03: link resume succeeded after 1 retries
>> [ =A0308.742869] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0308.742925] ata8.04: hard resetting link
>> [ =A0309.167567] ata8.04: softreset failed (SRST command error)
>> [ =A0309.167683] ata8.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0309.167689] ata8.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0318.720492] ata8.04: reset failed, giving up
>> [ =A0318.720498] ata8.15: hard resetting link
>> [ =A0318.720502] ata8: controller in dubious state, performing PORT_=
RST
>> [ =A0320.869657] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0321.577152] ata8.01: link resume succeeded after 1 retries
>> [ =A0321.679005] ata8.02: hard resetting link
>> [ =A0322.081996] ata8.02: link resume succeeded after 1 retries
>> [ =A0322.216966] ata8.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0322.216999] ata8.03: hard resetting link
>> [ =A0322.619825] ata8.03: link resume succeeded after 1 retries
>> [ =A0322.754896] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0322.754930] ata8.04: hard resetting link
>> [ =A0323.157612] ata8.04: link resume succeeded after 1 retries
>> [ =A0323.292583] ata8.04: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0323.292616] ata8.05: hard resetting link
>> [ =A0323.596925] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0323.640767] ata8.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0323.640773] ata8.02: 625142448 sectors, multi 0: LBA48
>> [ =A0323.640779] ata8.02: applying bridge limits
>> [ =A0323.698858] ata8.02: configured for UDMA/100
>> [ =A0323.745674] ata8.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0323.745680] ata8.03: 625142448 sectors, multi 0: LBA48
>> [ =A0323.803639] ata8.03: configured for UDMA/100
>> [ =A0323.842716] ata8.04: ATA-7: ST3320620A, 3.AAC, max UDMA/100
>> [ =A0323.842722] ata8.04: 625142448 sectors, multi 0: LBA48
>> [ =A0323.900831] ata8.04: configured for UDMA/100
>> [ =A0323.900899] ata8: EH complete
>> [ =A0326.030208] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
>> [ =A0326.030699] ata9.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 =
ports, feat 0x1/0x9
>> [ =A0326.033845] ata9.00: hard resetting link
>> [ =A0336.019051] ata9.00: softreset failed (timeout)
>> [ =A0339.012488] ata9.15: qc timeout (cmd 0xe4)
>> [ =A0339.012504] ata9.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0339.012508] ata9.00: reset failed, giving up
>> [ =A0339.012513] ata9.15: hard resetting link
>> [ =A0341.139699] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0341.140064] ata9.00: hard resetting link
>> [ =A0351.124563] ata9.00: softreset failed (timeout)
>> [ =A0354.117970] ata9.15: qc timeout (cmd 0xe4)
>> [ =A0354.117986] ata9.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0354.117991] ata9.00: reset failed, giving up
>> [ =A0354.117995] ata9.15: hard resetting link
>> [ =A0356.245238] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0356.245646] ata9.00: hard resetting link
>> [ =A0366.232072] ata9.00: softreset failed (timeout)
>> [ =A0369.225622] ata9.15: qc timeout (cmd 0xe4)
>> [ =A0369.225639] ata9.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0369.225643] ata9.00: reset failed, giving up
>> [ =A0369.225646] ata9.00: failed to recover link after 3 tries, disa=
bling
>> [ =A0369.225651] ata9.15: hard resetting link
>> [ =A0371.352723] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0371.658238] ata9.01: hard resetting link
>> [ =A0372.061197] ata9.01: link resume succeeded after 1 retries
>> [ =A0372.196197] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0372.196231] ata9.02: hard resetting link
>> [ =A0372.599024] ata9.02: link resume succeeded after 1 retries
>> [ =A0372.734004] ata9.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0372.734059] ata9.03: hard resetting link
>> [ =A0373.136813] ata9.03: link resume succeeded after 1 retries
>> [ =A0373.271772] ata9.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0373.271991] ata9.04: hard resetting link
>> [ =A0373.674613] ata9.04: link resume succeeded after 1 retries
>> [ =A0373.897067] ata9.04: softreset failed (SRST command error)
>> [ =A0373.897181] ata9.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0373.897186] ata9.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0383.249478] ata9.04: reset failed, giving up
>> [ =A0383.249485] ata9.15: hard resetting link
>> [ =A0383.249488] ata9: controller in dubious state, performing PORT_=
RST
>> [ =A0385.398590] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0385.703106] ata9.01: hard resetting link
>> [ =A0386.106062] ata9.01: link resume succeeded after 1 retries
>> [ =A0386.241016] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0386.241049] ata9.02: hard resetting link
>> [ =A0386.643858] ata9.02: link resume succeeded after 1 retries
>> [ =A0386.778833] ata9.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0386.778867] ata9.03: hard resetting link
>> [ =A0387.181678] ata9.03: link resume succeeded after 1 retries
>> [ =A0387.316679] ata9.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0387.316712] ata9.04: hard resetting link
>> [ =A0387.719469] ata9.04: link resume succeeded after 1 retries
>> [ =A0387.941933] ata9.04: softreset failed (SRST command error)
>> [ =A0388.051691] ata9.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0388.051697] ata9.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0397.294204] ata9.04: reset failed, giving up
>> [ =A0397.294211] ata9.15: hard resetting link
>> [ =A0397.294215] ata9: controller in dubious state, performing PORT_=
RST
>> [ =A0399.443466] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0399.748924] ata9.01: hard resetting link
>> [ =A0400.151923] ata9.01: link resume succeeded after 1 retries
>> [ =A0400.286954] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0400.287009] ata9.02: hard resetting link
>> [ =A0400.602829] ata9.02: softreset failed (SRST command error)
>> [ =A0400.602873] ata9.02: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0400.602878] ata9.02: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0410.264596] ata9.02: reset failed, giving up
>> [ =A0410.264602] ata9.15: hard resetting link
>> [ =A0412.380787] ata9.15: softreset failed (SRST command error)
>> [ =A0412.380793] ata9.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0420.242419] ata9.15: hard resetting link
>> [ =A0422.358667] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0422.358674] ata9.15: PMP revalidation failed (errno=3D-19)
>> [ =A0427.347591] ata9.15: hard resetting link
>> [ =A0429.474906] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0429.779395] ata9.01: hard resetting link
>> [ =A0430.182351] ata9.01: link resume succeeded after 1 retries
>> [ =A0430.317296] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0430.317351] ata9.02: hard resetting link
>> [ =A0430.720197] ata9.02: link resume succeeded after 1 retries
>> [ =A0430.855159] ata9.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0430.855193] ata9.03: hard resetting link
>> [ =A0431.257981] ata9.03: link resume succeeded after 1 retries
>> [ =A0431.392905] ata9.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0431.392939] ata9.04: hard resetting link
>> [ =A0431.795778] ata9.04: link resume succeeded after 1 retries
>> [ =A0432.018221] ata9.04: softreset failed (SRST command error)
>> [ =A0432.127979] ata9.04: failed to read SCR 0 (Emask=3D0x1)
>> [ =A0432.127985] ata9.04: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0441.370492] ata9.04: reset failed, giving up
>> [ =A0441.370497] ata9.04: failed to recover link after 3 tries, disa=
bling
>> [ =A0441.370503] ata9.15: hard resetting link
>> [ =A0441.370506] ata9: controller in dubious state, performing PORT_=
RST
>> [ =A0443.519744] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0444.228219] ata9.04: link resume succeeded after 1 retries
>> [ =A0444.330047] ata9.01: hard resetting link
>> [ =A0444.733074] ata9.01: link resume succeeded after 1 retries
>> [ =A0444.868066] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0444.868100] ata9.02: hard resetting link
>> [ =A0445.270895] ata9.02: link resume succeeded after 1 retries
>> [ =A0445.405825] ata9.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0445.405858] ata9.03: hard resetting link
>> [ =A0445.808708] ata9.03: link resume succeeded after 1 retries
>> [ =A0445.943636] ata9.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0445.943670] ata9.05: hard resetting link
>> [ =A0446.247941] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0446.296913] ata9.01: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0446.296919] ata9.01: 625142448 sectors, multi 0: LBA48
>> [ =A0446.296925] ata9.01: applying bridge limits
>> [ =A0446.355077] ata9.01: configured for UDMA/100
>> [ =A0446.395040] ata9.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0446.395046] ata9.02: 625142448 sectors, multi 0: LBA48
>> [ =A0446.395052] ata9.02: applying bridge limits
>> [ =A0446.452939] ata9.02: configured for UDMA/100
>> [ =A0446.495345] ata9.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0446.495351] ata9.03: 625142448 sectors, multi 0: LBA48
>> [ =A0446.495357] ata9.03: applying bridge limits
>> [ =A0446.553517] ata9.03: configured for UDMA/100
>> [ =A0446.553584] ata9: EH complete
>> [ =A0448.683166] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl =
0)
>> [ =A0448.683486] ata10.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6=
 ports, feat 0x1/0x9
>> [ =A0448.687214] ata10.00: hard resetting link
>> [ =A0458.672134] ata10.00: softreset failed (timeout)
>> [ =A0461.665544] ata10.15: qc timeout (cmd 0xe4)
>> [ =A0461.665560] ata10.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0461.665564] ata10.00: reset failed, giving up
>> [ =A0461.665569] ata10.15: hard resetting link
>> [ =A0463.792817] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
>> [ =A0463.793226] ata10.00: hard resetting link
>> [ =A0473.777653] ata10.00: softreset failed (timeout)
>> [ =A0476.771082] ata10.15: qc timeout (cmd 0xe4)
>> [ =A0476.771098] ata10.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0476.771103] ata10.00: reset failed, giving up
>> [ =A0476.771107] ata10.15: hard resetting link
>> [ =A0478.899314] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
>> [ =A0478.899908] ata10.00: hard resetting link
>> [ =A0488.887138] ata10.00: softreset failed (timeout)
>> [ =A0491.880576] ata10.15: qc timeout (cmd 0xe4)
>> [ =A0491.880592] ata10.00: failed to read SCR 0 (Emask=3D0x5)
>> [ =A0491.880596] ata10.00: reset failed, giving up
>> [ =A0491.880600] ata10.00: failed to recover link after 3 tries, dis=
abling
>> [ =A0491.880605] ata10.15: hard resetting link
>> [ =A0494.007817] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
>> [ =A0494.312333] ata10.01: hard resetting link
>> [ =A0494.715272] ata10.01: link resume succeeded after 1 retries
>> [ =A0494.850280] ata10.01: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0494.850313] ata10.02: hard resetting link
>> [ =A0495.253111] ata10.02: link resume succeeded after 1 retries
>> [ =A0495.388016] ata10.02: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0495.388049] ata10.03: hard resetting link
>> [ =A0495.790830] ata10.03: link resume succeeded after 1 retries
>> [ =A0495.925873] ata10.03: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0495.925907] ata10.04: hard resetting link
>> [ =A0496.328734] ata10.04: link resume succeeded after 1 retries
>> [ =A0496.463716] ata10.04: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0496.463771] ata10.05: hard resetting link
>> [ =A0496.768009] ata10.05: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 320)
>> [ =A0496.807384] ata10.01: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0496.807390] ata10.01: 625142448 sectors, multi 0: LBA48
>> [ =A0496.865535] ata10.01: configured for UDMA/100
>> [ =A0496.906478] ata10.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0496.906484] ata10.02: 625142448 sectors, multi 0: LBA48
>> [ =A0496.964626] ata10.02: configured for UDMA/100
>> [ =A0497.006300] ata10.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0497.006306] ata10.03: 625142448 sectors, multi 0: LBA48
>> [ =A0497.072809] ata10.03: configured for UDMA/100
>> [ =A0497.114788] ata10.04: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0497.114794] ata10.04: 625142448 sectors, multi 0: LBA48
>> [ =A0497.181051] ata10.04: configured for UDMA/100
>> [ =A0497.181118] ata10: EH complete
> =A0 :
>> [ =A0590.217860] systemd[1]: Startup finished in 2s 202ms 781us (ker=
nel) + 8min 18s 52ms 150us (initrd) + 1min 31s 63ms 470us (userspace) =3D=
 9min 51s 318ms 401us.
> --------
>
> --- 3.2.10 power cycle log ( patch is applied ) ---
> =A0 :
>> [ =A0 =A00.000000] Linux version 3.2.10-3.aa.fc16.i686.PAE (anezaki@=
server4) (gcc version 4.6.2 20111027 (Red Hat 4.6.2-1) (GCC) ) #1 SMP T=
hu Mar 22 08:14:54 JST 2012
> =A0 :
>> [ =A0 =A02.729562] ata7: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff0000 irq 17
>> [ =A0 =A02.729566] ata8: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff2000 irq 17
>> [ =A0 =A02.729570] ata9: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff4000 irq 17
>> [ =A0 =A02.729573] ata10: SATA max UDMA/100 host m128@0xfbfff400 por=
t 0xfbff6000 irq 17
> =A0 :
>> [ =A0 =A04.856167] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl=
 0)
>> [ =A0 =A04.856555] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, =
6 ports, feat 0x1/0x9
>> [ =A0 =A04.860371] ata7.00: hard resetting link
>> [ =A0 =A05.164779] ata7.00: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 320)
>> [ =A0 =A05.164812] ata7.01: hard resetting link
>> [ =A0 =A05.567672] ata7.01: link resume succeeded after 1 retries
>> [ =A0 =A05.669657] ata7.01: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 300)
>> [ =A0 =A05.669687] ata7.02: hard resetting link
>> [ =A0 =A06.072522] ata7.02: link resume succeeded after 1 retries
>> [ =A0 =A06.174570] ata7.02: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 300)
>> [ =A0 =A06.174601] ata7.03: hard resetting link
>> [ =A0 =A06.577435] ata7.03: link resume succeeded after 1 retries
>> [ =A0 =A06.679594] ata7.03: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 300)
>> [ =A0 =A06.679625] ata7.04: hard resetting link
>> [ =A0 =A07.082306] ata7.04: link resume succeeded after 1 retries
>> [ =A0 =A07.184388] ata7.04: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 300)
>> [ =A0 =A07.184419] ata7.05: hard resetting link
>> [ =A0 =A07.488718] ata7.05: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 320)
>> [ =A0 =A07.534065] ata7.00: ATA-7: ST3320620A, 3.AAC, max UDMA/100
>> [ =A0 =A07.534071] ata7.00: 625142448 sectors, multi 0: LBA48
>> [ =A0 =A07.534090] ata7.00: applying bridge limits
>> [ =A0 =A07.592213] ata7.00: configured for UDMA/100
>> [ =A0 =A07.596737] ata7.01: ATA-6: WDC WD2500BB-55GUC0, 08.02D08, ma=
x UDMA/100
>> [ =A0 =A07.596743] ata7.01: 488397168 sectors, multi 0: LBA48
>> [ =A0 =A07.602618] ata7.01: configured for UDMA/100
>> [ =A0 =A07.606381] ata7.02: ATA-7: Maxtor 7L250R0, BAJ41G20, max UDM=
A/133
>> [ =A0 =A07.606387] ata7.02: 490234752 sectors, multi 0: LBA48
>> [ =A0 =A07.606393] ata7.02: applying bridge limits
>> [ =A0 =A07.611626] ata7.02: configured for UDMA/100
>> [ =A0 =A07.623764] ata7.03: ATA-7: WDC WD2500BB-22RDA0, 20.00K20, ma=
x UDMA/100
>> [ =A0 =A07.623770] ata7.03: 488397168 sectors, multi 0: LBA48
>> [ =A0 =A07.624811] ata7.03: configured for UDMA/100
>> [ =A0 =A07.629200] ata7.04: ATA-6: WDC WD1600BB-55GUA0, 08.02D08, ma=
x UDMA/100
>> [ =A0 =A07.629205] ata7.04: 312581808 sectors, multi 0: LBA48
>> [ =A0 =A07.634917] ata7.04: configured for UDMA/100
>> [ =A0 =A07.635002] ata7: EH complete
>> [ =A0 34.285986] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
>> [ =A0 34.286427] ata8.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 =
ports, feat 0x1/0x9
>> [ =A0 34.288785] ata8.00: hard resetting link
>> [ =A0 34.593587] ata8.00: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 34.593617] ata8.01: hard resetting link
>> [ =A0 34.996435] ata8.01: link resume succeeded after 1 retries
>> [ =A0 35.098512] ata8.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 35.098543] ata8.02: hard resetting link
>> [ =A0 35.501314] ata8.02: link resume succeeded after 1 retries
>> [ =A0 35.603259] ata8.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 35.603290] ata8.03: hard resetting link
>> [ =A0 36.006195] ata8.03: link resume succeeded after 1 retries
>> [ =A0 36.108256] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 36.108287] ata8.04: hard resetting link
>> [ =A0 36.412602] ata8.04: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 36.412632] ata8.05: hard resetting link
>> [ =A0 36.717004] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 36.762712] ata8.00: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 36.762719] ata8.00: 625142448 sectors, multi 0: LBA48
>> [ =A0 36.845768] ata8.00: configured for UDMA/100
>> [ =A0 36.849244] ata8.01: ATA-5: WDC WD1200AB-22CBA1, 04.07B04, max =
UDMA/100
>> [ =A0 36.849250] ata8.01: 234441648 sectors, multi 0: LBA
>> [ =A0 36.849256] ata8.01: applying bridge limits
>> [ =A0 36.853680] ata8.01: configured for UDMA/100
>> [ =A0 36.891680] ata8.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 36.891686] ata8.02: 625142448 sectors, multi 0: LBA48
>> [ =A0 36.891692] ata8.02: applying bridge limits
>> [ =A0 36.949795] ata8.02: configured for UDMA/100
>> [ =A0 36.987189] ata8.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 36.987195] ata8.03: 625142448 sectors, multi 0: LBA48
>> [ =A0 37.045271] ata8.03: configured for UDMA/100
>> [ =A0 37.085915] ata8.04: ATA-7: ST3320620A, 3.AAC, max UDMA/100
>> [ =A0 37.085921] ata8.04: 625142448 sectors, multi 0: LBA48
>> [ =A0 37.144042] ata8.04: configured for UDMA/100
>> [ =A0 37.144107] ata8: EH complete
>> [ =A0 39.274927] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
>> [ =A0 39.275464] ata9.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 =
ports, feat 0x1/0x9
>> [ =A0 39.278021] ata9.00: hard resetting link
>> [ =A0 39.582515] ata9.00: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 39.582546] ata9.01: hard resetting link
>> [ =A0 39.985368] ata9.01: link resume succeeded after 1 retries
>> [ =A0 40.087368] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 40.087403] ata9.02: hard resetting link
>> [ =A0 40.490243] ata9.02: link resume succeeded after 1 retries
>> [ =A0 40.592245] ata9.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 40.592276] ata9.03: hard resetting link
>> [ =A0 40.995137] ata9.03: link resume succeeded after 1 retries
>> [ =A0 41.097150] ata9.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 41.097180] ata9.04: hard resetting link
>> [ =A0 41.500012] ata9.04: link resume succeeded after 1 retries
>> [ =A0 41.602003] ata9.04: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 41.602034] ata9.05: hard resetting link
>> [ =A0 41.906397] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 42.014200] ata9.00: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 42.014206] ata9.00: 625142448 sectors, multi 0: LBA48
>> [ =A0 42.072324] ata9.00: configured for UDMA/100
>> [ =A0 42.111485] ata9.01: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 42.111491] ata9.01: 625142448 sectors, multi 0: LBA48
>> [ =A0 42.111497] ata9.01: applying bridge limits
>> [ =A0 42.169647] ata9.01: configured for UDMA/100
>> [ =A0 42.218013] ata9.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 42.218019] ata9.02: 625142448 sectors, multi 0: LBA48
>> [ =A0 42.218025] ata9.02: applying bridge limits
>> [ =A0 42.276087] ata9.02: configured for UDMA/100
>> [ =A0 42.320248] ata9.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 42.320254] ata9.03: 625142448 sectors, multi 0: LBA48
>> [ =A0 42.320260] ata9.03: applying bridge limits
>> [ =A0 42.378414] ata9.03: configured for UDMA/100
>> [ =A0 42.379847] ata9.04: ATA-6: Maxtor 96147H6, ZAH814Y0, max UDMA/=
100
>> [ =A0 42.379853] ata9.04: 120064896 sectors, multi 0: LBA
>> [ =A0 42.379858] ata9.04: applying bridge limits
>> [ =A0 42.381615] ata9.04: configured for UDMA/100
>> [ =A0 42.381680] ata9: EH complete
>> [ =A0 44.512318] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl =
0)
>> [ =A0 44.512925] ata10.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6=
 ports, feat 0x1/0x9
>> [ =A0 44.515715] ata10.00: hard resetting link
>> [ =A0 44.819948] ata10.00: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 320)
>> [ =A0 44.819979] ata10.01: hard resetting link
>> [ =A0 45.222761] ata10.01: link resume succeeded after 1 retries
>> [ =A0 45.324781] ata10.01: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0 45.324812] ata10.02: hard resetting link
>> [ =A0 45.727639] ata10.02: link resume succeeded after 1 retries
>> [ =A0 45.829636] ata10.02: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0 45.829666] ata10.03: hard resetting link
>> [ =A0 46.232522] ata10.03: link resume succeeded after 1 retries
>> [ =A0 46.334558] ata10.03: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0 46.334589] ata10.04: hard resetting link
>> [ =A0 46.737368] ata10.04: link resume succeeded after 1 retries
>> [ =A0 46.839471] ata10.04: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0 46.839501] ata10.05: hard resetting link
>> [ =A0 47.143791] ata10.05: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 320)
>> [ =A0 47.248372] ata10.00: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 47.248378] ata10.00: 625142448 sectors, multi 0: LBA48
>> [ =A0 47.306392] ata10.00: configured for UDMA/100
>> [ =A0 47.353307] ata10.01: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 47.353313] ata10.01: 625142448 sectors, multi 0: LBA48
>> [ =A0 47.411454] ata10.01: configured for UDMA/100
>> [ =A0 47.456257] ata10.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 47.456263] ata10.02: 625142448 sectors, multi 0: LBA48
>> [ =A0 47.514395] ata10.02: configured for UDMA/100
>> [ =A0 47.553006] ata10.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 47.553012] ata10.03: 625142448 sectors, multi 0: LBA48
>> [ =A0 47.611199] ata10.03: configured for UDMA/100
>> [ =A0 47.652126] ata10.04: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 47.652132] ata10.04: 625142448 sectors, multi 0: LBA48
>> [ =A0 47.710076] ata10.04: configured for UDMA/100
>> [ =A0 47.710143] ata10: EH complete
> =A0 :
>> [ =A0 68.114484] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 st=
ate recovery directory
>> [ =A0 68.129524] NFSD: starting 90-second grace period
> =A0 :
> --------
>
> --- 3.2.10 warm reboot log ( patch is applied ) ---
> =A0 :
>> [ =A0 =A00.000000] Linux version 3.2.10-3.aa.fc16.i686.PAE (anezaki@=
server4) (gcc version 4.6.2 20111027 (Red Hat 4.6.2-1) (GCC) ) #1 SMP T=
hu Mar 22 08:14:54 JST 2012
> =A0 :
>> [ =A0 =A02.699127] ata7: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff0000 irq 17
>> [ =A0 =A02.699131] ata8: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff2000 irq 17
>> [ =A0 =A02.699135] ata9: SATA max UDMA/100 host m128@0xfbfff400 port=
 0xfbff4000 irq 17
>> [ =A0 =A02.699139] ata10: SATA max UDMA/100 host m128@0xfbfff400 por=
t 0xfbff6000 irq 17
> =A0 :
>> [ =A0 =A04.826250] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl=
 0)
>> [ =A0 =A04.826612] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, =
6 ports, feat 0x1/0x9
>> [ =A0 =A04.830596] ata7.00: hard resetting link
>> [ =A0 =A05.134832] ata7.00: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 320)
>> [ =A0 =A05.134863] ata7.01: hard resetting link
>> [ =A0 =A05.537729] ata7.01: link resume succeeded after 1 retries
>> [ =A0 =A05.639812] ata7.01: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 300)
>> [ =A0 =A05.639843] ata7.02: hard resetting link
>> [ =A0 =A06.042561] ata7.02: link resume succeeded after 1 retries
>> [ =A0 =A06.144687] ata7.02: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 300)
>> [ =A0 =A06.144717] ata7.03: hard resetting link
>> [ =A0 =A06.547490] ata7.03: link resume succeeded after 1 retries
>> [ =A0 =A06.649674] ata7.03: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 300)
>> [ =A0 =A06.649705] ata7.04: hard resetting link
>> [ =A0 =A07.052371] ata7.04: link resume succeeded after 1 retries
>> [ =A0 =A07.154419] ata7.04: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 300)
>> [ =A0 =A07.154449] ata7.05: hard resetting link
>> [ =A0 =A07.458756] ata7.05: SATA link up 1.5 Gbps (SStatus 113 SCont=
rol 320)
>> [ =A0 =A07.503939] ata7.00: ATA-7: ST3320620A, 3.AAC, max UDMA/100
>> [ =A0 =A07.503945] ata7.00: 625142448 sectors, multi 0: LBA48
>> [ =A0 =A07.503951] ata7.00: applying bridge limits
>> [ =A0 =A07.562109] ata7.00: configured for UDMA/100
>> [ =A0 =A07.783927] ata7.01: ATA-6: WDC WD2500BB-55GUC0, 08.02D08, ma=
x UDMA/100
>> [ =A0 =A07.783934] ata7.01: 488397168 sectors, multi 0: LBA48
>> [ =A0 =A07.789650] ata7.01: configured for UDMA/100
>> [ =A0 =A07.793380] ata7.02: ATA-7: Maxtor 7L250R0, BAJ41G20, max UDM=
A/133
>> [ =A0 =A07.793386] ata7.02: 490234752 sectors, multi 0: LBA48
>> [ =A0 =A07.793392] ata7.02: applying bridge limits
>> [ =A0 =A07.798892] ata7.02: configured for UDMA/100
>> [ =A0 =A07.811970] ata7.03: ATA-7: WDC WD2500BB-22RDA0, 20.00K20, ma=
x UDMA/100
>> [ =A0 =A07.811976] ata7.03: 488397168 sectors, multi 0: LBA48
>> [ =A0 =A07.813162] ata7.03: configured for UDMA/100
>> [ =A0 =A07.817674] ata7.04: ATA-6: WDC WD1600BB-55GUA0, 08.02D08, ma=
x UDMA/100
>> [ =A0 =A07.817680] ata7.04: 312581808 sectors, multi 0: LBA48
>> [ =A0 =A07.823575] ata7.04: configured for UDMA/100
>> [ =A0 =A07.823643] ata7: EH complete
>> [ =A0 13.041087] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
>> [ =A0 13.041499] ata8.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 =
ports, feat 0x1/0x9
>> [ =A0 13.044606] ata8.00: hard resetting link
>> [ =A0 13.348670] ata8.00: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 13.348701] ata8.01: hard resetting link
>> [ =A0 13.751514] ata8.01: link resume succeeded after 1 retries
>> [ =A0 13.853570] ata8.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 13.853602] ata8.02: hard resetting link
>> [ =A0 14.256455] ata8.02: link resume succeeded after 1 retries
>> [ =A0 14.358436] ata8.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 14.358467] ata8.03: hard resetting link
>> [ =A0 14.761281] ata8.03: link resume succeeded after 1 retries
>> [ =A0 14.863336] ata8.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 14.863367] ata8.04: hard resetting link
>> [ =A0 15.167619] ata8.04: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 15.167650] ata8.05: hard resetting link
>> [ =A0 15.471979] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 15.516626] ata8.00: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 15.516632] ata8.00: 625142448 sectors, multi 0: LBA48
>> [ =A0 15.574797] ata8.00: configured for UDMA/100
>> [ =A0 15.578265] ata8.01: ATA-5: WDC WD1200AB-22CBA1, 04.07B04, max =
UDMA/100
>> [ =A0 15.578271] ata8.01: 234441648 sectors, multi 0: LBA
>> [ =A0 15.578277] ata8.01: applying bridge limits
>> [ =A0 15.582726] ata8.01: configured for UDMA/100
>> [ =A0 15.628882] ata8.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 15.628888] ata8.02: 625142448 sectors, multi 0: LBA48
>> [ =A0 15.628894] ata8.02: applying bridge limits
>> [ =A0 15.686967] ata8.02: configured for UDMA/100
>> [ =A0 15.730640] ata8.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 15.730646] ata8.03: 625142448 sectors, multi 0: LBA48
>> [ =A0 15.788720] ata8.03: configured for UDMA/100
>> [ =A0 15.835469] ata8.04: ATA-7: ST3320620A, 3.AAC, max UDMA/100
>> [ =A0 15.835475] ata8.04: 625142448 sectors, multi 0: LBA48
>> [ =A0 15.893578] ata8.04: configured for UDMA/100
>> [ =A0 15.893644] ata8: EH complete
>> [ =A0 18.024017] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
>> [ =A0 18.024436] ata9.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 =
ports, feat 0x1/0x9
>> [ =A0 18.026843] ata9.00: hard resetting link
>> [ =A0 18.331659] ata9.00: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 18.331690] ata9.01: hard resetting link
>> [ =A0 18.734523] ata9.01: link resume succeeded after 1 retries
>> [ =A0 18.836552] ata9.01: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 18.836583] ata9.02: hard resetting link
>> [ =A0 19.239387] ata9.02: link resume succeeded after 1 retries
>> [ =A0 19.341569] ata9.02: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 19.341600] ata9.03: hard resetting link
>> [ =A0 19.744289] ata9.03: link resume succeeded after 1 retries
>> [ =A0 19.846327] ata9.03: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 19.846359] ata9.04: hard resetting link
>> [ =A0 20.249125] ata9.04: link resume succeeded after 1 retries
>> [ =A0 20.351165] ata9.04: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
>> [ =A0 20.351196] ata9.05: hard resetting link
>> [ =A0 20.655534] ata9.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
>> [ =A0 20.697625] ata9.00: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 20.697631] ata9.00: 625142448 sectors, multi 0: LBA48
>> [ =A0 20.755791] ata9.00: configured for UDMA/100
>> [ =A0 20.803812] ata9.01: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 20.803820] ata9.01: 625142448 sectors, multi 0: LBA48
>> [ =A0 20.803828] ata9.01: applying bridge limits
>> [ =A0 20.861999] ata9.01: configured for UDMA/100
>> [ =A0 20.907473] ata9.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 20.907481] ata9.02: 625142448 sectors, multi 0: LBA48
>> [ =A0 20.907489] ata9.02: applying bridge limits
>> [ =A0 20.965567] ata9.02: configured for UDMA/100
>> [ =A0 21.009201] ata9.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 21.009208] ata9.03: 625142448 sectors, multi 0: LBA48
>> [ =A0 21.009235] ata9.03: applying bridge limits
>> [ =A0 21.067373] ata9.03: configured for UDMA/100
>> [ =A0 21.068864] ata9.04: ATA-6: Maxtor 96147H6, ZAH814Y0, max UDMA/=
100
>> [ =A0 21.068870] ata9.04: 120064896 sectors, multi 0: LBA
>> [ =A0 21.068875] ata9.04: applying bridge limits
>> [ =A0 21.070684] ata9.04: configured for UDMA/100
>> [ =A0 21.070764] ata9: EH complete
>> [ =A0 23.200571] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl =
0)
>> [ =A0 23.200949] ata10.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6=
 ports, feat 0x1/0x9
>> [ =A0 23.203737] ata10.00: hard resetting link
>> [ =A0 23.508163] ata10.00: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 320)
>> [ =A0 23.508194] ata10.01: hard resetting link
>> [ =A0 23.911059] ata10.01: link resume succeeded after 1 retries
>> [ =A0 24.013053] ata10.01: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0 24.013084] ata10.02: hard resetting link
>> [ =A0 24.415910] ata10.02: link resume succeeded after 1 retries
>> [ =A0 24.517980] ata10.02: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0 24.518012] ata10.03: hard resetting link
>> [ =A0 24.920928] ata10.03: link resume succeeded after 1 retries
>> [ =A0 25.022770] ata10.03: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0 25.022801] ata10.04: hard resetting link
>> [ =A0 25.425701] ata10.04: link resume succeeded after 1 retries
>> [ =A0 25.527681] ata10.04: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 300)
>> [ =A0 25.527712] ata10.05: hard resetting link
>> [ =A0 25.832000] ata10.05: SATA link up 1.5 Gbps (SStatus 113 SContr=
ol 320)
>> [ =A0 25.879126] ata10.00: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 25.879132] ata10.00: 625142448 sectors, multi 0: LBA48
>> [ =A0 25.937192] ata10.00: configured for UDMA/100
>> [ =A0 25.978792] ata10.01: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 25.978798] ata10.01: 625142448 sectors, multi 0: LBA48
>> [ =A0 26.036936] ata10.01: configured for UDMA/100
>> [ =A0 26.077728] ata10.02: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 26.077734] ata10.02: 625142448 sectors, multi 0: LBA48
>> [ =A0 26.136026] ata10.02: configured for UDMA/100
>> [ =A0 26.183072] ata10.03: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 26.183078] ata10.03: 625142448 sectors, multi 0: LBA48
>> [ =A0 26.241261] ata10.03: configured for UDMA/100
>> [ =A0 26.279920] ata10.04: ATA-7: ST3320620A, 3.AAD, max UDMA/100
>> [ =A0 26.279926] ata10.04: 625142448 sectors, multi 0: LBA48
>> [ =A0 26.337727] ata10.04: configured for UDMA/100
>> [ =A0 26.337793] ata10: EH complete
> =A0 :
>> [ =A0 50.854018] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 st=
ate recovery directory
>> [ =A0 50.910997] NFSD: starting 90-second grace period
> =A0 :
> --------
>
> Best Regards,
> Akira
