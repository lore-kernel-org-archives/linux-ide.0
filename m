From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Fix ata_id_has_dword_io to return DWORD I/O support properly
Date: Thu, 18 Dec 2008 21:42:16 +0100
Message-ID: <200812182142.16533.bzolnier@gmail.com>
References: <494A5BBF.8000807@inf.tu-dresden.de> <494A837A.50801@garzik.org> <494A8768.4080100@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:39456 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbYLRUpi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 15:45:38 -0500
Received: by bwz14 with SMTP id 14so2431873bwz.13
        for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2008 12:45:36 -0800 (PST)
In-Reply-To: <494A8768.4080100@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mario Schwalbe <schwalbe@inf.tu-dresden.de>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Thursday 18 December 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Jeff Garzik wrote:
> 
> >> This patch fixes ata_id_has_dword_io to return 1 (supported) if
> >> the drive is compliant to ATA2 or newer and evaluates the config
> >> word for older drives.
> 
> >> Signed-off-by: Mario Schwalbe <schwalbe@inf.tu-dresden.de>
> 
> >> diff --git a/include/linux/ata.h b/include/linux/ata.h
> >> index a53318b..d0d6a9c 100644
> >> --- a/include/linux/ata.h
> >> +++ b/include/linux/ata.h
> >> @@ -700,12 +700,12 @@ static inline int ata_id_has_tpm(const u16 *id)
> 
> >>  static inline int ata_id_has_dword_io(const u16 *id)
> >>  {
> >> -    /* ATA 8 reuses this flag for "trusted" computing */
> >> -    if (ata_id_major_version(id) > 7)
> >> -        return 0;
> >> -    if (id[ATA_ID_DWORD_IO] & (1 << 0))
> >> -        return 1;
> >> -    return 0;
> >> +    /* This flag is defined up to ATA1 and deprecated since then
> >> +       (ATA 8 reuses this flag for "trusted" computing). */
> >> +    if (ata_id_major_version(id) <= 1)
> >> +        return (id[ATA_ID_DWORD_IO] & (1 << 0)) != 0;
> >> +    /* later revision drives support DWORD I/O just fine */
> >> +    return 1;
> 
> > This seems like a risky assumption...
> 
>     Not at all, I think. It's total mystery how "DWORD I/O" could've been even 
> (not) supported by a *drive* at all. Support of "DWORD I/O" is a property of 
> the PATA controller. Frankly speaking, I don't think that this function is at 
> all useful...

Indeed, this function can be probably removed altogether later...

OTOH the current patch is safe even for 2.6.28 (based on years of experience
with the check that we had in IDE subsystem) and will fix some libata drivers
(pata_legacy, pata_qdi and pata_winbond) to use dword IO on >= ATA-2 devices.

[ In reality this a regression fix for IDE -> libata conversion as it is a
  huge performance improvement for the above mentioned DMA-less drivers. ]

Jeff, I would like to merge it through IDE tree since the other patch depends
on it but if you want to go ahead and push it to Linus earlier feel free to
do it (or I can include it into the next IDE fixes pull request if you like).

Thanks,
Bart
