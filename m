From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] ata_piix: make DVD Drive recognisable on systems with
 Intel Sandybridge chipsets(v1)
Date: Thu, 6 Oct 2011 19:53:46 +0800
Message-ID: <CACVXFVO9TWDC-+5g2n6knWErWL4U8zNqBxy99Jc4hDB1VGzKQQ@mail.gmail.com>
References: <1317433412-15963-1-git-send-email-ming.lei@canonical.com>
	<4E8C2724.7030608@mvista.com>
	<CACVXFVPrZELDuO=Aa+HrccpwnOw7UB5eQEW0=y_aUEt794rHgA@mail.gmail.com>
	<4E8D854F.6000107@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47169 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935288Ab1JFLxt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 07:53:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RBmWK-0001ah-38
	for linux-ide@vger.kernel.org; Thu, 06 Oct 2011 11:53:48 +0000
Received: by ywb5 with SMTP id 5so2481272ywb.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2011 04:53:47 -0700 (PDT)
In-Reply-To: <4E8D854F.6000107@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: htejun@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, seth.heasley@intel.com, Alan Cox <alan@linux.intel.com>

On Thu, Oct 6, 2011 at 6:39 PM, Sergei Shtylyov <sshtylyov@mvista.com> =
wrote:
> Hello.
>
> On 06-10-2011 13:27, Ming Lei wrote:
>
>>>> This quirk patch fixes one kind of bug inside some Intel Sandybrid=
ge
>>>> chipsets, see reports from
>
>>>> =A0 =A0 =A0 =A0https://bugzilla.kernel.org/show_bug.cgi?id=3D40592=
=2E
>
>>>> Many guys also have reported the problem before:
>
>>>> =A0 =A0 =A0 =A0https://bugs.launchpad.net/bugs/737388
>>>> =A0 =A0 =A0 =A0https://bugs.launchpad.net/bugs/794642
>>>> =A0 =A0 =A0 =A0https://bugs.launchpad.net/bugs/782389
>>>> =A0 =A0 =A0 =A0......
>
>>>> With help from Tejun, the problem is found to be caused by 32bit P=
IO
>>>> mode, so introduce the quirk patch to disable 32bit PIO on SATA pi=
ix
>>>> for some Sandybridge CPT chipsets.
>
>>>> Seth also tested the patch on all five affected chipsets
>>>> (pci device ID: 0x1c00, 0x1c01, 0x1d00, 0x1e00, 0x1e01), and found
>>>> the patch does fix the problem.
>
>>>> Tested-by: Heasley, Seth<seth.heasley@intel.com>
>>>> Cc: Alan Cox<alan@linux.intel.com>
>>>> Signed-off-by: Ming Lei<ming.lei@canonical.com>
>>>> Signed-off-by: Tejun Heo<htejun@gmail.com>
>>>> ---
>>>> =A0drivers/ata/ata_piix.c | =A0 37 +++++++++++++++++++++++++++++++=
+-----
>>>> =A0include/linux/libata.h | =A0 =A01 +
>>>> =A02 files changed, 33 insertions(+), 5 deletions(-)
>
>>>> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
>>>> index 43107e9..70095be 100644
>>>> --- a/drivers/ata/ata_piix.c
>>>> +++ b/drivers/ata/ata_piix.c
>>>> @@ -113,6 +113,8 @@ enum {
>>>> =A0 =A0 =A0 =A0PIIX_PATA_FLAGS =A0 =A0 =A0 =A0 =3D ATA_FLAG_SLAVE_=
POSS,
>>>> =A0 =A0 =A0 =A0PIIX_SATA_FLAGS =A0 =A0 =A0 =A0 =3D ATA_FLAG_SATA |=
 PIIX_FLAG_CHECKINTR,
>>>>
>>>> + =A0 =A0 =A0 PIIX_FLAG_PIO16 =A0 =A0 =A0 =A0 =3D ATA_FLAG_PIO16,
>
>>> =A0 It's not clear why are you declaring a ganeric flag and then ad=
d a
>>> local
>>> name for it...
>
>> It is just same with other flags, isn't it?
>
> =A0 No. Read the the ata_piix.c source attentively, looking for PIIX_=
=46LAG_*
> definitions.
>
>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>> index efd6f98..dc68de5 100644
>>>> --- a/include/linux/libata.h
>>>> +++ b/include/linux/libata.h
>>>> @@ -207,6 +207,7 @@ enum {
>>>> =A0 =A0 =A0 =A0ATA_FLAG_SW_ACTIVITY =A0 =A0=3D (1<< =A022), /* dri=
ver supports sw
>>>> activity
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0* led */
>>>> =A0 =A0 =A0 =A0ATA_FLAG_NO_DIPM =A0 =A0 =A0 =A0=3D (1<< =A023), /*=
 host not happy with DIPM
>>>> */
>>>> + =A0 =A0 =A0 ATA_FLAG_PIO16 =A0 =A0 =A0 =A0 =A0=3D (1<< =A024), =A0=
/*16bit PIO */
>>>
>>> =A0 Please, fix the formatting. Or better totally remove this.
>
>> It is used to describe if the controller only supports 16bit PIO, an=
d it
>> is introduced to fix the problem on SNB chips.
>
> =A0 I don't yet see why it should be a generic flag: we have
> ata_bmdma_port_ops and ata_bmdma32_port_ops to be used for 16-bit and=
 32-bit
> PIO. You're only using this flag locally to ata_piix.c, hence it shou=
ld be
> local to that file.

This flag is to stored into ata_port flags, so it is better to define a=
 global
flag. Otherwise, you have to select a value carefully which must not be
defined in ata_port flags already, which way is very error-prone and no=
t
friendly.

Anyway, I have not see obvious drawbacks to define a global ata_port
flag.

thanks,
--
Ming Lei
