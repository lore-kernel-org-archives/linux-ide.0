From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Fwd: libata-pmp patch for 3.2.x and later for eSATA Port
 Multiplier Sil3726
Date: Wed, 21 Mar 2012 17:09:02 +0800
Message-ID: <CAMHSBOWg+rxxrVjf05r1tYDpW1S75XzdrLQ+U8TrjC9okRYtuA@mail.gmail.com>
References: <4F5ECD06.3000608@yahoo.co.jp>
	<4F5F7C4C.7080800@teksavvy.com>
	<4F662AFB.9050106@yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F662AFB.9050106@yahoo.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: "ANEZAKI, Akira" <fireblade1230@yahoo.co.jp>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

Akira,

- When you do the test between 3.1 and 3.2, do you cold boot the
machine every time?
- does the problem with 3.2 happens when you just reboot the machine
instead of cold booting?
Looking at your log, it seems you are using old drives that take a
long time to spinup.

We can see there are progress between 3.2.3 and 3.2.9:
In 3.2.3, we fail with qc_timeout and some drives are disabled.
In 3.2.9, we take time to spinup the drives, but finally all are found.

The patch you proposed seems to only have been tested with warm
reboot, not power cycle.
Please see http://www.spinics.net/lists/linux-ide/msg41699.html and
http://www.spinics.net/lists/linux-ide/msg41700.html for an
explanation why this patch is need.

Gwendal.

On Mon, Mar 19, 2012 at 2:35 AM, ANEZAKI, Akira
<fireblade1230@yahoo.co.jp> wrote:
> You may see these messages more easier when cold boot even if there a=
re
> a few Sil3726 port multiplier:
> =A0:
>> [ =A0 =A00.000000] Linux version 3.2.10-3.fc16.i686.PAE (mockbuild@x=
86-02.phx2.fedoraproject.org) (gcc version 4.6.2 20111027 (Red Hat 4.6.=
2-1) (GCC) ) #1 SMP Thu Mar 15 20:37:01 UTC 2012
> =A0:
>> [ =A0 =A03.764070] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl=
 0)
>> [ =A0 =A03.764394] ata5.15: Port Multiplier 1.1, 0x1095:0x3726 r23, =
6 ports, feat 0x1/0x9
>> [ =A0 =A03.767216] ata5.00: hard resetting link
>> [ =A0 =A04.105264] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SCont=
rol 320)
>> [ =A0 =A04.105300] ata5.01: hard resetting link
>> [ =A0 =A04.421064] ata5.01: softreset failed (SRST command error)
>> [ =A0 =A04.421078] ata5.01: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0 =A04.421085] ata5.01: reset failed (errno=3D-85), retrying in =
10 secs
>> [ =A0 14.105089] ata5.01: reset failed, giving up
>> [ =A0 14.105100] ata5.15: hard resetting link
>> [ =A0 16.226094] ata5.15: softreset failed (SRST command error)
>> [ =A0 16.226102] ata5.15: reset failed (errno=3D-5), retrying in 8 s=
ecs
>> [ =A0 24.105243] ata5.15: hard resetting link
>> [ =A0 26.226231] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 26.226242] ata5.15: PMP revalidation failed (errno=3D-19)
>> [ =A0 31.226079] ata5.15: hard resetting link
>> [ =A0 33.358086] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 33.358388] ata5.00: hard resetting link
>> [ =A0 33.696256] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 320)
>> [ =A0 33.696291] ata5.01: hard resetting link
>> [ =A0 34.034255] ata5.01: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 34.034292] ata5.02: hard resetting link
>> [ =A0 34.460042] ata5.02: softreset failed (SRST command error)
>> [ =A0 34.460064] ata5.02: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0 34.460070] ata5.02: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 44.034216] ata5.02: reset failed, giving up
>> [ =A0 44.034225] ata5.15: hard resetting link
>> [ =A0 44.034230] ata5: controller in dubious state, performing PORT_=
RST
>> [ =A0 46.188102] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 46.188403] ata5.00: hard resetting link
>> [ =A0 46.526267] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 320)
>> [ =A0 46.526301] ata5.01: hard resetting link
>> [ =A0 46.864262] ata5.01: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 46.864297] ata5.02: hard resetting link
>> [ =A0 47.202253] ata5.02: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 47.202288] ata5.03: hard resetting link
>> [ =A0 47.628038] ata5.03: softreset failed (SRST command error)
>> [ =A0 47.628052] ata5.03: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0 47.628058] ata5.03: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 57.202189] ata5.03: reset failed, giving up
>> [ =A0 57.202197] ata5.15: hard resetting link
>> [ =A0 57.202202] ata5: controller in dubious state, performing PORT_=
RST
>> [ =A0 59.356051] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 59.356397] ata5.00: hard resetting link
>> [ =A0 59.694252] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 320)
>> [ =A0 59.694287] ata5.01: hard resetting link
>> [ =A0 60.032253] ata5.01: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 60.032290] ata5.02: hard resetting link
>> [ =A0 60.370261] ata5.02: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 60.370296] ata5.03: hard resetting link
>> [ =A0 60.708269] ata5.03: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 60.708304] ata5.04: hard resetting link
>> [ =A0 61.013360] ata5.04: SATA link down (SStatus 0 SControl 320)
>> [ =A0 61.013422] ata5.05: hard resetting link
> =A0:
>> [ =A0 63.850067] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 0=
)
>> [ =A0 63.850427] ata6.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 =
ports, feat 0x1/0x9
>> [ =A0 63.853419] ata6.00: hard resetting link
>> [ =A0 64.180241] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 320)
>> [ =A0 64.180280] ata6.01: hard resetting link
>> [ =A0 64.606036] ata6.01: softreset failed (SRST command error)
>> [ =A0 64.606054] ata6.01: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0 64.606061] ata6.01: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 74.180035] ata6.01: reset failed, giving up
>> [ =A0 74.180046] ata6.15: hard resetting link
>> [ =A0 74.180052] ata6: controller in dubious state, performing PORT_=
RST
>> [ =A0 76.334081] ata6.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 76.334404] ata6.00: hard resetting link
>> [ =A0 76.661266] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 320)
>> [ =A0 76.661305] ata6.01: hard resetting link
>> [ =A0 76.988320] ata6.01: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 76.988357] ata6.02: hard resetting link
>> [ =A0 77.414044] ata6.02: softreset failed (SRST command error)
>> [ =A0 77.414057] ata6.02: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0 77.414065] ata6.02: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0 86.988104] ata6.02: reset failed, giving up
>> [ =A0 86.988114] ata6.15: hard resetting link
>> [ =A0 86.988120] ata6: controller in dubious state, performing PORT_=
RST
>> [ =A0 89.142149] ata6.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0 89.142465] ata6.00: hard resetting link
>> [ =A0 89.469329] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 320)
>> [ =A0 89.469367] ata6.01: hard resetting link
>> [ =A0 89.796252] ata6.01: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 89.796289] ata6.02: hard resetting link
>> [ =A0 90.123242] ata6.02: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0 90.123277] ata6.03: hard resetting link
>> [ =A0 90.549042] ata6.03: softreset failed (SRST command error)
>> [ =A0 90.549058] ata6.03: failed to read SCR 0 (Emask=3D0x40)
>> [ =A0 90.549065] ata6.03: reset failed (errno=3D-85), retrying in 10=
 secs
>> [ =A0100.123063] ata6.03: reset failed, giving up
>> [ =A0100.123072] ata6.15: hard resetting link
>> [ =A0100.123078] ata6: controller in dubious state, performing PORT_=
RST
>> [ =A0102.277076] ata6.15: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 0)
>> [ =A0102.277392] ata6.00: hard resetting link
>> [ =A0102.604240] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 320)
>> [ =A0102.604278] ata6.01: hard resetting link
>> [ =A0102.931241] ata6.01: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0102.931279] ata6.02: hard resetting link
>> [ =A0103.258256] ata6.02: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0103.258292] ata6.03: hard resetting link
>> [ =A0103.585257] ata6.03: SATA link up 3.0 Gbps (SStatus 123 SContro=
l 300)
>> [ =A0103.585294] ata6.04: hard resetting link
>> [ =A0103.890368] ata6.04: SATA link down (SStatus 0 SControl 320)
>> [ =A0103.890433] ata6.05: hard resetting link
>> [ =A0104.195336] ata6.05: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 320)
> =A0:
>
>
> (2012/03/14 01:56), Mark Lord wrote:
>> Sounds like a regression from 3.1 to 3.2.
>> Copying linux-ide & Jeff.
>>
>> -------- Original Message --------
>> Subject: libata-pmp patch for 3.2.x and later for eSATA Port Multipl=
ier Sil3726
>> Date: Tue, 13 Mar 2012 13:28:54 +0900
>> From: ANEZAKI, Akira <fireblade1230@yahoo.co.jp>
>> To: linux-kernel@vger.kernel.org
>>
>> Hi!
>>
>> I'm in trouble on a PC that has 6 eSATA port multiplier.
>>
>>>From kernel 3.2.x, kernel fails to boot when many HDDs are connected=
 to
>> many eSATA port multiplier with Sil3726.
>>
>> Kernel is repeating eSATA bus reset while booting and spend long tim=
e,
>> and result into fail to boot with timeout. It causes that some HDDs
>> cannot be seen from kernel on a PC that has 6 Sil3726 port multiplie=
r.
>> dmesg contains many reset messages while booting like this:
>> =A0 =A0:
>>> [ =A0 48.060454] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl =
0)
>>> [ =A0 48.061150] ata6.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6=
 ports, feat 0x1/0x9
>>> [ =A0 48.063158] ata6.00: hard resetting link
>>> [ =A0 48.401020] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 320)
>>> [ =A0 48.401080] ata6.01: hard resetting link
>>> [ =A0 48.825741] ata6.01: softreset failed (SRST command error)
>>> [ =A0 48.935499] ata6.01: failed to read SCR 0 (Emask=3D0x1)
>>> [ =A0 48.935505] ata6.01: reset failed (errno=3D-85), retrying in 1=
0 secs
>> =A0 =A0:
>>> [ =A0294.950152] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl =
0)
>>> [ =A0294.950453] ata9.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6=
 ports, feat 0x1/0x9
>>> [ =A0294.953382] ata9.00: hard resetting link
>>> [ =A0304.937981] ata9.00: softreset failed (timeout)
>>> [ =A0307.931302] ata9.15: qc timeout (cmd 0xe4)
>>> [ =A0307.931318] ata9.00: failed to read SCR 0 (Emask=3D0x5)
>>> [ =A0307.931322] ata9.00: reset failed, giving up
>>> [ =A0307.931327] ata9.15: hard resetting link
>>> [ =A0310.058635] ata9.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
>>> [ =A0310.059016] ata9.00: hard resetting link
>>> [ =A0320.044490] ata9.00: softreset failed (timeout)
>>> [ =A0323.037851] ata9.15: qc timeout (cmd 0xe4)
>>> [ =A0323.037868] ata9.00: failed to read SCR 0 (Emask=3D0x5)
>>> [ =A0323.037872] ata9.00: reset failed, giving up
>> =A0 =A0:
>>> [ =A0556.513676] systemd[1]: Job dev-disk-by\x2dlabel-WORK.device/s=
tart timed out.
>>> [ =A0556.513693] systemd[1]: Job fedora-autorelabel-mark.service/st=
art failed with result 'dependency'.
>>> [ =A0556.513816] systemd[1]: Job fedora-autorelabel.service/start f=
ailed with result 'dependency'.
>>> [ =A0556.513833] systemd[1]: Job local-fs.target/start failed with =
result 'dependency'.
>>> [ =A0556.513846] systemd[1]: Triggering OnFailure=3D dependencies o=
f local-fs.target.
>>> [ =A0556.515352] systemd[1]: Job mnt-work.mount/start failed with r=
esult 'dependency'.
>>> [ =A0556.515368] systemd[1]: Job dev-disk-by\x2dlabel-WORK.device/s=
tart failed with result 'timeout'.
>>> [ =A0556.851000] systemd[1]: Startup finished in 2s 212ms 906us (ke=
rnel) + 7min 44s 688ms 483us (initrd) + 1min 30s 977ms 147us (userspace=
) =3D 9min 17s 878ms 536us.
>>
>> When only one sentence in drivers/ata/libata-pmp.c only for Sil3726 =
back
>> to that in kernel 3.1.x, this problem is not seen. I attached the pa=
tch
>> file.
>>
>> This patch solves the problem on my PC but I can't understand ata
>> subsystem. So I'm afraid of side effect.
>>
>> Can you consider this patch?
>>
>> Best Regards,
>> ANEZAKI, Akira
>>
>> -------- Original Message --------
>> Subject: [Bug 787468] boot fails by timeout while activating RAIDs w=
ith
>> many HDDs
>> Date: Mon, 12 Mar 2012 16:30:45 -0400
>> From: bugzilla@redhat.com
>> To: fireblade1230@yahoo.co.jp
>>
>> Please do not reply directly to this email. All additional
>> comments should be made in the comments box of this bug.
>>
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D787468
>>
>> --- Comment #20 from Dave Jones <davej@redhat.com> 2012-03-12 16:30:=
43
>> EDT ---
>> can you post this patch upstream to linux-kernel@vger.kernel.org ?
>> if it is acceptable there, we will add it to the Fedora kernel.
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
