From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] 2.6.35 libata support for > 512 byte sectors (e.g. 4K Native)
Date: Mon, 16 Aug 2010 12:17:28 -0700
Message-ID: <AANLkTik4RNvaE5OrFq3NmZ+-9DKhAAaNQ3cdPg38zOr2@mail.gmail.com>
References: <AANLkTikSSmP5f1csa=xPTR=EqY4D5a=6t2oDVkZ7cA-v@mail.gmail.com>
	<CAC4B8726E86A142B27A9E9A2F2F12470149041A4E@rrsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:14554 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab0HPTRc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Aug 2010 15:17:32 -0400
In-Reply-To: <CAC4B8726E86A142B27A9E9A2F2F12470149041A4E@rrsmsx505.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Wilcox, Matthew R" <matthew.r.wilcox@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, Linux IDE <linux-ide@vger.kernel.org>, Gwendal Grignou <gwendal@google.com>, LKML <linux-kernel@vger.kernel.org>

On Sat, Aug 14, 2010 at 9:37 PM, Wilcox, Matthew R
<matthew.r.wilcox@intel.com> wrote:
> If you will insist on sending to my Outlook address, you'll get repli=
es in standard broken Outlook format. =C2=A0You've been warned.

You trumped my Gmail warning. I fold. :)

>
> ---
>
> +/* BUG: Big endian systems need accesses to "id" wrapped with le16_t=
o_cpu().
> + */
>
> No, it's already been converted. =C2=A0See ata_dev_read_id().

Ah - good. I'll remove the comment.

>
> I'm not sure about your use of a switch to set the sector size. =C2=A0=
Have you checked the code that GCC generates for this?

The switch probably sucks unless we could weight the order of the
tests. E.g. common cases first. But it's just an implementation detail
that is relatively easy to replace with the bitmap you had implemented
before.

>
> All the places you dereference dev->sdev are within a callchain from =
->queuecommand; sdev can't possibly go away.
> It'd be clearer that this is the case if you used scmd->device->secto=
r_size instead of dev->sdev->sector_size.

Thank you - that looks much better to me too.

> --
>
> @@ -516,7 +515,7 @@ int ata_cmd_ioctl(struct scsi_device *scsidev, vo=
id __user *arg)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(scsi_cmd, 0, sizeof(scsi_cmd));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (args[3]) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argsize =3D SECTOR=
_SIZE * args[3];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argsize =3D ATA_SE=
CT_SIZE * args[3];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argbuf =3D kma=
lloc(argsize, GFP_KERNEL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argbuf =3D=
=3D NULL) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0rc =3D -ENOMEM;
>
> I think this is wrong. =C2=A0The ioctl does PIO Data-in; as such, it =
should use the native sector size, not 512.
> That said, there's a possibility of data corruption for programs whic=
h use this ioctl, assuming a 512-byte sector size when it's natively 4k=
=2E
> This one's tricky and needs serious thought. =C2=A0I might error it i=
f sector_size isn't 512 bytes :-)
> It's a legacy ioctl anyway, right?

I have no idea. If it's tricky, I probably have it wrong.
Anyone else have guidance here?


> ---
>
> I also remember Alan pointing out that some ATA controllers don't sup=
port non-512-byte commands, and we should have a 'safe for large sector=
s' flag set by the controller.

This could also be added as a separate patch. I didn't run into this
problem so I can't say which controllers would have problems.

thanks for the helpful feedback!
I'll post a V2 later today.

thanks,
grant

>
> -----Original Message-----
> From: Grant Grundler [mailto:grundler@google.com]
> Sent: Saturday, August 14, 2010 5:01 PM
> To: Jeff Garzik; Tejun Heo
> Cc: Linux IDE; Wilcox, Matthew R; Gwendal Grignou; LKML
> Subject: [PATCH] 2.6.35 libata support for > 512 byte sectors (e.g. 4=
K Native)
>
> Attached patch enables my x86 machine to recognize and talk to a "Nat=
ive 4K" SATA device.
>
> When I started working on this, I didn't know Matthew Wilcox had post=
ed a similar patch 2 years ago:
> =C2=A0 http://git.kernel.org/?p=3Dlinux/kernel/git/willy/ata.git;a=3D=
shortlog;h=3Drefs/heads/ata-large-sectors
>
> Gwendal Grignou pointed me at the the above code and small portions o=
f this patch include Matthew's work. That's why Mathew is first on the =
"Signed-off-by:". I've NOT included his use of a bitmap to determine
> 512 vs Native for ATA command block size - just used a simple table.
> And bugs are almost certainly mine.
>
> Lastly, the patch has been tested with a native 4K 'Engineering Sampl=
e' drive provided by Hitachi GST.
>
> Signed-off-by: Matthew Wilcox <matthew.r.wilcox@intel.com>
> Signed-off-by: Grant Grundler <grundler@google.com>
> Reviewed-by: Gwendal Grignou <gwendal@google.com>
>
> -----
>
> Gwendal's review of this patch had him concerned about access to "dev=
->sdev->sector_size" may have risks (e.g. sdev goes away before dev doe=
s). =C2=A0I didn't like adding additional fields to ata_dev that duplic=
ate what scsi is doing and this seems to be working so far. But since I=
 don't know how dev->sdev is protected/syncronized (despite how libata =
and scsi are joined at the hip), I hope someone else can comment on if =
my usage of dev->sdev->sector_size is a problem and why.
>
> I believe use of ata_id_logical_per_physical_sectors() was wrong. I'v=
e replaced it with ata_id_log2_per_physical_sector() and cleaned up how=
 block size word and alignment are referenced. It's alot easier to read=
 where those functions are used now.
>
>
> Here is the kernel output from hotplugging the SATA drive on my machi=
ne (using Marvell 7042 controller):
>
> [ 2468.301218] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4010000 act=
ion 0xe frozen [ 2468.301225] ata4: edma_err_cause=3D00000010 pp_flags=3D=
00000000, dev connect [ 2468.301240] ata4: SError: { PHYRdyChg DevExch =
} [ 2468.301257] ata4: hard resetting link [ 2471.701117] ata4: SATA li=
nk up 1.5 Gbps (SStatus 113 SControl 300) [ 2471.740390] ata4.00: HPA d=
etected: current 9770670, native 78165360 [ 2471.740399] ata4.00: ATA-7=
: Hitachi HTSxxxxxxxxxxxx, yyyyyyyy, max UDMA/100 [ 2471.740402] ata4.0=
0: 9770670 sectors, multi 0: LBA48 NCQ (depth 31/32) [ 2471.764465] ata=
4.00: configured for UDMA/100 [ 2471.764501] ata4: EH complete
> [ 2471.764988] scsi 4:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA =C2=A0 =C2=
=A0 =C2=A0Hitachi
> HTSxxxxxxxxxxxx PQ: 0 ANSI: 5
> [ 2471.782914] sd 4:0:0:0: [sdd] 9770670 4096-byte logical blocks:
> (40.0 GB/37.2 GiB)
> [ 2471.787093] sd 4:0:0:0: [sdd] Write Protect is off [ 2471.787120] =
sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00 [ 2471.788768] sd 4:0:0:0: [s=
dd] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 2471.792293] sd 4:0:0:0: [sdd] 9770670 4096-byte logical blocks:
> (40.0 GB/37.2 GiB)
> [ 2471.792834] sd 4:0:0:0: Attached scsi generic sg3 type 0 [ 2471.79=
9370] =C2=A0sdd: unknown partition table [ 2471.845582] sd 4:0:0:0: [sd=
d] 9770670 4096-byte logical blocks:
> (40.0 GB/37.2 GiB)
> [ 2471.853763] sd 4:0:0:0: [sdd] Attached SCSI disk
>
> I was able to dd to/from the device and pull SMART data (not shown an=
d probably not able to share.)
>
> If someone has "Advanced Format Developers Kit" SATA drives from idem=
a.org, I'd appreciate any test reports.
>
> thanks
> grant
>
> [ patch NOT inlined because gmail will word-wrap and make a mess of i=
t. Please use attached filed.]
>
