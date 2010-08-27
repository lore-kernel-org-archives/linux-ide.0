From: Gwendal Grignou <gwendal@google.com>
Subject: Re: possible esata regression in 2.6.35
Date: Fri, 27 Aug 2010 01:19:49 -0700
Message-ID: <AANLkTi=fQsHVpNu2TZeDNdcofoorFFfsASU=XDqUB9b4@mail.gmail.com>
References: <4C702070.5020809@jungers.net>
	<4C71808B.7070704@garzik.org>
	<4C718115.8070103@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C718115.8070103@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, kernel@teksavvy.com
Cc: Nicolas Jungers <nicolas@jungers.net>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

I can reproduce the problem on uptsream-linux using a PC with Marvell
7042 controller and Sil3726 PMP. Without the SIl3726, it works fine.

What I can see on the SATA analyzer [I will send clean trace tomorrow]
is the disk send the DATA FIS back to the PMP, but the PMP does not
manage to have the data accepted by the host.

Non data commands work fine.

In dmesg:
[10058.404047] ata29: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[10058.404742] ata29.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6
ports, feat 0x1/0x9
[10058.405250] ata29.00: hard resetting link
[10058.809151] ata29.00: link resume succeeded after 1 retries
[10058.911613] ata29.01: hard resetting link
[10059.217572] ata29.02: hard resetting link
[10059.523572] ata29.03: hard resetting link
[10059.829505] ata29.04: hard resetting link
[10060.134572] ata29.05: hard resetting link
[10065.440079] ata29.03: qc timeout (cmd 0xec)
[10065.440085] ata29.03: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[10065.440092] ata29.15: hard resetting link
[10065.947049] ata29.15: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[10065.947737] ata29.00: hard resetting link
[10066.352106] ata29.00: link resume succeeded after 1 retries
[10066.454616] ata29.01: hard resetting link
[10066.760591] ata29.02: hard resetting link
[10067.066570] ata29.03: hard resetting link
[10067.372505] ata29.05: hard resetting link
[10077.677071] ata29.03: qc timeout (cmd 0xec)
[10077.677076] ata29.03: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[10077.677081] ata29.15: hard resetting link
[10078.184073] ata29.15: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[10078.184783] ata29.00: hard resetting link
[10078.589185] ata29.00: link resume succeeded after 1 retries
[10078.691593] ata29.01: hard resetting link
[10078.997592] ata29.02: hard resetting link
[10079.303571] ata29.03: hard resetting link
[10079.609505] ata29.04: hard resetting link
[10079.914572] ata29.05: hard resetting link
[10110.220078] ata29.03: qc timeout (cmd 0xec)
[10110.220083] ata29.03: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[10110.220087] ata29.03: failed to recover link after 3 tries, disablin=
g
[10110.220094] ata29.15: hard resetting link
[10110.727044] ata29.15: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
[10111.033375] ata29.00: hard resetting link
[10111.338571] ata29.01: hard resetting link
[10111.644591] ata29.02: hard resetting link
[10111.950594] ata29.05: hard resetting link
[10112.256643] ata29: EH complete


Gwendal.




On Sun, Aug 22, 2010 at 12:57 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 08/22/2010 03:54 PM, Jeff Garzik wrote:
>>
>> On 08/21/2010 02:52 PM, Nicolas Jungers wrote:
>>>
>>> My arm box doesn't succeed to use my esata port multiplier (addonic=
s
>>> sil3726 based). It was working well with 2.6.34.1 and 2.6.34.4 but =
not
>>> with both 2.6.35.2 and 2.6.35.3. I haven't test other kernels.
>>>
>>> The kernels are from http://sheeva.with-linux.com/sheeva/ with for
>>> example the following config
>>> http://sheeva.with-linux.com/sheeva/2.6.35.3/sheeva-2.6.35.3.config
>>>
>>> The symptoms are in the console a loop on the esata links. Here is =
the
>>> start of it:
>>>
>>> ata2: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe froze=
n
>>> ata2: edma_err_cause=3D00000010 pp_flags=3D00000000, dev connect
>>> ata2: SError: { PHYRdyChg DevExch }
>>> ata2: hard resetting link
>>> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
>>> ata2.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/=
0x9
>>
>> Can you post or link to the entire dmesg?
>>
>> Notably, we need to see the probe messages to determine what SATA ch=
ip
>> you are using... From the edma_err_cause config I'd guess sata_mv, b=
ut
>> more info would be useful.
>
> Nevermind, I see the reply (it got auto-sorted into the wrong folder
> locally).
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
