From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Drives missing at boot
Date: Mon, 2 Aug 2010 15:07:11 -0700
Message-ID: <AANLkTinwJLE=jjwG5zL8UBO91tzDpX36_W9GORKag8RK@mail.gmail.com>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>
	<4C2F5ECB.1040505@kernel.org>
	<AANLkTinBn35687znO2_IxI3s1opkXrG2HpCRgsejNbMq@mail.gmail.com>
	<4C2F61AB.9030806@kernel.org>
	<AANLkTilYOT45q8OUJ-_V61_fnYy9HIk6GAv5ZPiomCaT@mail.gmail.com>
	<4C317C04.20500@kernel.org>
	<AANLkTilupyieml9yaWO9BUNPmQQ0g2w1HLWj6R9MwDZf@mail.gmail.com>
	<4C32CE50.6010501@kernel.org>
	<AANLkTikehTO1j6Gd7Y_g32_P6Yg9KB8Z8qwbNJh10aOU@mail.gmail.com>
	<4C341598.6040004@kernel.org>
	<AANLkTik4zkcIyVxwtX8GA1BsQSZaAeODpPlY3mRVBc-4@mail.gmail.com>
	<4C34A1D5.1090202@kernel.org>
	<AANLkTilgQSu3qi7qoTtjnV22r-8Sh1hbDAB_nlPImWNt@mail.gmail.com>
	<4C34B8BE.5080504@kernel.org>
	<AANLkTilDbrA6lLPSOAtA8_4mLNkUZibHweTliqU5jd03@mail.gmail.com>
	<4C44BD42.3030904@kernel.org>
	<7141c88bc8c27f26c2187252c0594318.squirrel@thechecks.ca>
	<4C45AF40.7030800@kernel.org>
	<AANLkTinxDjPCk46eItZrXziTbf6efqvNNNTbkZDXIbns@mail.gmail.com>
	<4C483BF4.3090006@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56390 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0HBWHS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Aug 2010 18:07:18 -0400
In-Reply-To: <4C483BF4.3090006@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Paul Check <paul@thechecks.ca>, Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, Jul 22, 2010 at 5:39 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 07/21/2010 10:54 PM, Mark Knecht wrote:
>> =C2=A0 =C2=A0Looks like I had a failure today. First one in weeks an=
d only the
>> 3rd or 4th boot with this newer patch file. One of the two drives
>> making a RAID0 wasn't found so /dev/md11 (constructed from /dev/sdd
>> and /dev/sde) couldn't be started. I did a cold reboot and the drive
>> was found.
>>
>> =C2=A0 =C2=A0If it matters, and it probably doesn't, the failure cam=
e on a boot
>> which had a scheduled fsck to do of /dev/md5 - my main / drive. I
>> don't see how that would make a difference but I figure why leave th=
e
>> info out. That's why the times are so much larger in the dmesg file.
>> (I think)
>>
>> =C2=A0 =C2=A0dmesg attached. I patched the Gentoo kernel if it makes=
 a
>> difference, same as I did with the earlier patch.
>>
>> mark@c2stable ~ $ uname -a
>> Linux c2stable 2.6.34-gentoo-r2 #1 SMP PREEMPT Sun Jul 18 14:09:48 P=
DT
>> 2010 x86_64 Intel(R) Core(TM) i7 CPU X 980 @ 3.33GHz GenuineIntel
>> GNU/Linux
>> mark@c2stable ~ $
>
> Hmmm... that's weird. =C2=A0Can you please make sure the patch is act=
ually
> applied? =C2=A0Adding a printk("XXX patch applied!\n") near other cha=
nges
> usually is easy enough. =C2=A0Also, can you please apply resume-dbg-1=
=2Epatch
> too and reproduce the failure and post log?
>
> Thanks.
>
> --
> tejun
>

Hi Tejun,
   I'm finally home and trying to get back to this. I'm really a bad
programmer so I don't know what I've done wrong but it seems patch
isn't happy with me.

c2stable linux # patch --dry-run -p1 <../ata_piix-sidpr-lock.patch
patching file drivers/ata/ata_piix.c
patch: **** malformed patch at line 13:

c2stable linux #

   Here's the change I tried to make to a copy of the file:

c2stable linux # cat ../ata_piix-sidpr-lock.patch
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 7409f98..3971bc0 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -158,6 +158,7 @@ struct piix_map_db {
 struct piix_host_priv {
        const int *map;
        u32 saved_iocfg;
+       spinlock_t sidpr_lock;  /* FIXME: remove once locking in EH is =
fixed */
+       printk("MWK - ata_sidpr patch applied!\n");
        void __iomem *sidpr;
 };

@@ -951,12 +952,15 @@ static int piix_sidpr_scr_read(struct ata_link *l=
ink,
                               unsigned int reg, u32 *val)
 {
        struct piix_host_priv *hpriv =3D link->ap->host->private_data;
+       unsigned long flags;

        if (reg >=3D ARRAY_SIZE(piix_sidx_map))
                return -EINVAL;

+       spin_lock_irqsave(&hpriv->sidpr_lock, flags);
        piix_sidpr_sel(link, reg);
        *val =3D ioread32(hpriv->sidpr + PIIX_SIDPR_DATA);
+       spin_unlock_irqrestore(&hpriv->sidpr_lock, flags);
        return 0;
 }

@@ -964,12 +968,15 @@ static int piix_sidpr_scr_write(struct ata_link *=
link,
                                unsigned int reg, u32 val)
 {
        struct piix_host_priv *hpriv =3D link->ap->host->private_data;
+       unsigned long flags;

        if (reg >=3D ARRAY_SIZE(piix_sidx_map))
                return -EINVAL;

+       spin_lock_irqsave(&hpriv->sidpr_lock, flags);
        piix_sidpr_sel(link, reg);
        iowrite32(val, hpriv->sidpr + PIIX_SIDPR_DATA);
+       spin_unlock_irqrestore(&hpriv->sidpr_lock, flags);
        return 0;
 }

@@ -1566,6 +1573,7 @@ static int __devinit piix_init_one(struct pci_dev=
 *pdev,
        hpriv =3D devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
        if (!hpriv)
                return -ENOMEM;
+       spin_lock_init(&hpriv->sidpr_lock);

        /* Save IOCFG, this will be used for cable detection, quirk
         * detection and restoration on detach.  This is necessary
c2stable linux #

   Maybe you can shoot back something that's done correctly and I'll
start testing.

   I've tried booting a few times. I've had 3 cold boot failures so
far. No warm boot failures. Each time it failed on cold boot a warm
boot fixed it.

Thanks,
Mark
