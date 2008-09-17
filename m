From: "Alexander Beregalov" <a.beregalov@gmail.com>
Subject: Re: NCQ on Promise SATA300 TX4
Date: Thu, 18 Sep 2008 02:25:40 +0400
Message-ID: <a4423d670809171525q3515bc26r982d5d7312a38a1b@mail.gmail.com>
References: <1221687728.12558.12.camel@tim-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:42483 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767AbYIQWZm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 18:25:42 -0400
Received: by gxk9 with SMTP id 9so30485593gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 15:25:40 -0700 (PDT)
In-Reply-To: <1221687728.12558.12.camel@tim-desktop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Besard <tim.besard@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

2008/9/18 Tim Besard <tim.besard@gmail.com>:
> Hi,
>
> I recently bough a Promise SATA300 TX4 controller, which I am using in
> combination with an NCQ-capable harddrive. As the controller supports
> NCQ [1], and the libata webpages seems to indicate [2] that the
> sata_promise driver does as well, I am currently trying to enable NCQ
> (kernel 2.6.27).
>
> Without any luck however, my dmesg log indicates the following:
> [    4.244047] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    4.253636] ata1.00: ATA-7: ST3500320AS, SD04, max UDMA/133
> [    4.253639] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth
> 0/32)
> [    4.268850] ata1.00: configured for UDMA/133
>
> And the NCQ queue depth flag seems read-only:
> tim@tim-desktop:~$ sudo echo 31 > /sys/block/sdb/device/queue_depth
This works as
(sudo echo 31) > /sys/block/sdb/device/queue_depth
try
sudo sh -c "echo 31 > /sys/block/sdb/device/queue_depth"
> bash: /sys/block/sdb/device/queue_depth: Permission denied
>
> The read-only nature of the queue_depth field seems to indicate that the
> SATA module doesn't have NCQ support, but this contradicts with what I
> read on the libata page.
>
> Could you shed some light on this issue? And if the driver doesn't
> support NCQ for this card, is there another way to accomplish this
> (without having to buy a new controller)?
>
> References:
> 1:
> http://www.promise.com/product/product_detail_eng.asp?segment=Non-RAID%
> 20HBAs&product_id=139
> 2: http://linux-ata.org/driver-status.html#tx2
>
> Thanks in advance,
> Tim
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
