From: Gwendal Grignou <gwendal@google.com>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED (resolved)
Date: Thu, 12 Aug 2010 07:09:36 -0700
Message-ID: <AANLkTikGFJcAUKTcrjO_bNnZHBkAVhFENOs_o7HmN1po@mail.gmail.com>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se>
	<4C3D134B.2090604@gmail.com>
	<Pine.LNX.4.61.1007140955080.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007171422530.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007211404480.24693@envy.nxs.se>
	<Pine.LNX.4.61.1007211433360.24693@envy.nxs.se>
	<4C531A40.6080804@gmail.com>
	<Pine.LNX.4.61.1008011625490.24693@envy.nxs.se>
	<AANLkTikCqugAgM7zd=8H-hchN8b8tmZsP=NHgf+mNvc0@mail.gmail.com>
	<Pine.LNX.4.61.1008020720250.24693@envy.nxs.se>
	<AANLkTi=YDuEYt4BK4T4bJH3cY5GujC-tCV4D-ORcbDVT@mail.gmail.com>
	<Pine.LNX.4.61.1008030732251.24693@envy.nxs.se>
	<4C5B979E.8050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:45126 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760176Ab0HLOJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Aug 2010 10:09:42 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id o7CE9ePj030243
	for <linux-ide@vger.kernel.org>; Thu, 12 Aug 2010 07:09:40 -0700
Received: from ywg4 (ywg4.prod.google.com [10.192.7.4])
	by wpaz21.hot.corp.google.com with ESMTP id o7CE9dBF031503
	for <linux-ide@vger.kernel.org>; Thu, 12 Aug 2010 07:09:39 -0700
Received: by ywg4 with SMTP id 4so478694ywg.23
        for <linux-ide@vger.kernel.org>; Thu, 12 Aug 2010 07:09:38 -0700 (PDT)
In-Reply-To: <4C5B979E.8050606@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tomas Lund <tlund@nxs.se>, linux-ide@vger.kernel.org

Hi Robert,

I had the same problem with locked drive earlier, causing a lot of
unnecessary errors. See "Do not send RW commands to locked disks."
thread.
It works right now, but it does not take in account disks with wrong
information in their identify page. I need to improve this patch: the
first IO will go through and the error handler will check the drive is
locked and then set a bit to prevent sending more command until the
UNLOCK command is issued.

Gwendal.

On Thu, Aug 5, 2010 at 10:03 PM, Robert Hancock <hancockrwd@gmail.com> =
wrote:
> On 08/02/2010 11:33 PM, Tomas Lund wrote:
>> On Mon, 2 Aug 2010, Robert Hancock wrote:
>>
>>> On Mon, Aug 2, 2010 at 1:21 AM, Tomas Lund <tlund@nxs.se> wrote:
>>>
>>>> I have unlocked and tested a total of 4 disks now, both the samsun=
g 1TB and 3 of the WDC 2TB disks. Thank you very much! Left to do: test=
 that everything is working with the PMP aswell.
>>>
>>> Good to hear.
>>
>> I now have all of my drives up and working, running on the PMP and e=
verything is looking perfectly. Thanks again for your help.
>>
>>>> Question: Would it be unreasonable to request that the kernel woul=
d issue the apropriate ATA-commands to a disk as soon as it is detected=
, and not try to read from it if it is locked? It would have been reall=
y, really nice to just get the error message "drive is locked".
>>>
>>> It should be possible to indicate that, yes. I'll look into it when=
 I get a chance, if someone doesn't beat me to it..
>>
>> Perfect!
>>
>> //tlund
>
> Can you test this patch out, assuming you still have anything left th=
at's locked
> (or can relock one of them to try it out)? It should print out a warn=
ing in
> dmesg upon recognizing the device if it's in the security locked stat=
e.
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index ddf8e48..d4ec163 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2561,6 +2561,11 @@ int ata_dev_configure(struct ata_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dma_dir_string);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (print_info && ata_id_security_locked(dev->id))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ata_dev_printk(dev, KERN_WARNING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "appears to have ATA se=
curity enabled and locked - "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "media may be inaccessi=
ble until unlocked\n");
> +
> =A0 =A0 =A0 =A0/* determine max_sectors */
> =A0 =A0 =A0 =A0dev->max_sectors =3D ATA_MAX_SECTORS;
> =A0 =A0 =A0 =A0if (dev->flags & ATA_DFLAG_LBA48)
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index fe6e681..f2359fa 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -684,6 +684,22 @@ static inline int ata_id_hpa_enabled(const u16 *=
id)
> =A0 =A0 =A0 =A0return id[ATA_ID_COMMAND_SET_1] & (1 << 10);
> =A0}
>
> +static inline int ata_id_security_locked(const u16 *id)
> +{
> + =A0 =A0 =A0 /* Yes children, word 83 valid bits cover word 82 data =
*/
> + =A0 =A0 =A0 if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) !=3D 0x4000)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 /* And 87 covers 85-87 */
> + =A0 =A0 =A0 if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) !=3D 0x4000)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 /* Check command sets enabled as well as supported */
> + =A0 =A0 =A0 if ((id[ATA_ID_CFS_ENABLE_1] & (1 << 1)) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if ((id[ATA_ID_COMMAND_SET_1] & (1 << 1)) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return (id[ATA_ID_DLF] & 0x0007) =3D=3D 0x0007;
> +}
> +
> =A0static inline int ata_id_has_wcache(const u16 *id)
> =A0{
> =A0 =A0 =A0 =A0/* Yes children, word 83 valid bits cover word 82 data=
 */
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
