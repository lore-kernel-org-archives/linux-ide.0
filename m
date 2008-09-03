From: "Petr Jelen" <petr.jelen@gmail.com>
Subject: Re: Highpoint RocketRaid 1720 support in sata_mv
Date: Wed, 3 Sep 2008 21:39:14 +0200
Message-ID: <ae2e8fb00809031239x78d1c123j6680772cdd7b3310@mail.gmail.com>
References: <ae2e8fb00806281400l54d9378ey22b7a952a6315088@mail.gmail.com>
	 <48674B92.3030801@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_18706_26467481.1220470754197"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:33548 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbYICTjQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Sep 2008 15:39:16 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1459847eyi.37
        for <linux-ide@vger.kernel.org>; Wed, 03 Sep 2008 12:39:14 -0700 (PDT)
In-Reply-To: <48674B92.3030801@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, mlord@pobox.com, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

------=_Part_18706_26467481.1220470754197
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Mark,

Somehow the patch didn't make it into 2.6.26.
Could you plz. submit it for 2.6.27?

The patch against 2.6.27-rc4 is attached.

Thank you,
Petr Jelen

2008/6/29 Mark Lord <liml@rtr.ca>:
>> Petr Jelen wrote:
>> I have a simple patch for sata_mv.c, which adds support for Highpoint
>> RocketRaid 1720 adapter (2 SATA2 ports on PCI bus).
>> The adapter has Marvel 88SX6042-BCZ1 on board.
>>
>> The patch is against 2.6.25.9 and I have tested it. I could normally
>> work with my disks (in JBOD mode).
>
> ..
>
> Looks simple enough.
>
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
>
> Jeff, can you push this one-liner (or equivalent) out for 2.6.26?
> I don't have a dev tree with me on the road here,
> so the line offsets probably differ.
>
>
> diff -urN linux-2.6.25.9/drivers/ata/sata_mv.c
> linux-2.6.25.9-new/drivers/ata/sata_mv.c
> --- linux-2.6.25.9/drivers/ata/sata_mv.c        2008-06-24
> 23:09:06.000000000 +0200
> +++ linux-2.6.25.9-new/drivers/ata/sata_mv.c    2008-06-28
> 22:36:22.000000000 +0200
> @@ -695,7 +695,8 @@
>       { PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
>       { PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
>       { PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
> -       /* RocketRAID 1740/174x have different identifiers */
> +       /* RocketRAID 1720/174x have different identifiers */
> +       { PCI_VDEVICE(TTI, 0x1720), chip_6042 },
>       { PCI_VDEVICE(TTI, 0x1740), chip_508x },
>       { PCI_VDEVICE(TTI, 0x1742), chip_508x },
>
>
> Best Regards,
> Petr Jelen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

------=_Part_18706_26467481.1220470754197
Content-Type: text/x-diff; name=rr1720.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fkocqdp00
Content-Disposition: attachment; filename=rr1720.patch

LS0tIGxpbnV4LTIuNi4yNi9kcml2ZXJzL2F0YS9zYXRhX212LmMub3JpZwkyMDA4LTA4LTI5IDIx
OjM1OjQ1LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjI2L2RyaXZlcnMvYXRhL3NhdGFf
bXYuYwkyMDA4LTA4LTI5IDIxOjM2OjM4LjAwMDAwMDAwMCArMDIwMApAQCAtNjY3LDcgKzY2Nyw4
IEBACiAJeyBQQ0lfVkRFVklDRShNQVJWRUxMLCAweDUwNDEpLCBjaGlwXzUwNHggfSwKIAl7IFBD
SV9WREVWSUNFKE1BUlZFTEwsIDB4NTA4MCksIGNoaXBfNTA4MCB9LAogCXsgUENJX1ZERVZJQ0Uo
TUFSVkVMTCwgMHg1MDgxKSwgY2hpcF81MDh4IH0sCi0JLyogUm9ja2V0UkFJRCAxNzQwLzE3NHgg
aGF2ZSBkaWZmZXJlbnQgaWRlbnRpZmllcnMgKi8KKwkvKiBSb2NrZXRSQUlEIDE3MjAvMTc0eCBo
YXZlIGRpZmZlcmVudCBpZGVudGlmaWVycyAqLworCXsgUENJX1ZERVZJQ0UoVFRJLCAweDE3MjAp
LCBjaGlwXzYwNDIgfSwKIAl7IFBDSV9WREVWSUNFKFRUSSwgMHgxNzQwKSwgY2hpcF81MDh4IH0s
CiAJeyBQQ0lfVkRFVklDRShUVEksIDB4MTc0MiksIGNoaXBfNTA4eCB9LAogCg==
------=_Part_18706_26467481.1220470754197--
