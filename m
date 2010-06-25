From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ahci_platform: Provide for vendor specific init
Date: Fri, 25 Jun 2010 16:40:43 +0900
Message-ID: <AANLkTikV91et1ZQyxr33ctzcZg0GWOvICs2OfwCTSoZM@mail.gmail.com>
References: <1277441858-26993-1-git-send-email-jassisinghbrar@gmail.com>
	<4C245A42.1070203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43451 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab0FYHkq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 03:40:46 -0400
Received: by vws9 with SMTP id 9so3560687vws.19
        for <linux-ide@vger.kernel.org>; Fri, 25 Jun 2010 00:40:45 -0700 (PDT)
In-Reply-To: <4C245A42.1070203@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, Jassi Brar <jassi.brar@samsung.com>

On Fri, Jun 25, 2010 at 4:26 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 06/25/2010 12:57 AM, Jassi Brar wrote:
>>
>> From: Jassi Brar<jassi.brar@samsung.com>
>>
>> Some AHCI implementations may use Vendor Specific HBA[A0h, FFh]
>> and/or Port[70h, 7Fh] registers to 'prepare' for initialization.
>> For that, the platform needs memory mapped address of AHCI registers=
=2E
>>
>> This patch adds the 'mmio' argument and reorders the call to
>> platform init function.
>>
>> Signed-off-by: Jassi Brar<jassi.brar@samsung.com>
>> ---
>> =C2=A0drivers/ata/ahci_platform.c =C2=A0 | =C2=A0 23 +++++++++++++--=
--------
>> =C2=A0include/linux/ahci_platform.h | =C2=A0 =C2=A02 +-
>> =C2=A02 files changed, 14 insertions(+), 11 deletions(-)
>
> It is also possible that platforms may need the init to prep the MMIO=
 area
> for use? =C2=A0Anton, does this patch work for you, or introduce such=
 a problem?
IMO platforms that need such prep(setup iommu ?) have the option to do =
it in
earlier machine init code, but platforms that need to access vendor
specific regs
have no way other than to duplicate ioremap.
Btw, I see no impact on CNS3XXX.

Thanks.
