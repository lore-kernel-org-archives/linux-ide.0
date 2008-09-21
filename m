From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE-TAPE NULL terminate strings.
Date: Sun, 21 Sep 2008 23:24:10 +0400
Message-ID: <48D69F5A.9010201@ru.mvista.com>
References: <20080921185138.GA16310@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:58026 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751052AbYIUTXO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Sep 2008 15:23:14 -0400
In-Reply-To: <20080921185138.GA16310@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark de Wever <koraq@xs4all.nl>
Cc: Gadi Oxman <gadio@netvision.net.il>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Mark de Wever wrote:

> After updating my kernel to 2.6.26 the output for the ide-tape drive
> during booting is garbled eg
> ide-tape: hdd <-> ht0: Seagate <98>=DF8A51|1=C0<81>=DC=BA<98>=DF STT2=
0000A rev 8A51|1=C0<81>=DC=BA<98>=DF

> This patch fixes the problem by NULL terminating the strings.

> Regards,
> Mark de Wever

> PS: please CC me since I'm not subscribed.
> PPS: there are more problems with my tapestreamer in 2.6.26 but I'll
> post a separate message for that.

> Signed-off-by: Mark de Wever <koraq@xs4all.nl>

> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 1bce84b..fd87b43 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -2354,6 +2354,10 @@ static void idetape_get_inquiry_results(ide_dr=
ive_t *drive)
>  	ide_fixstring(product_id, 18, 0);
>  	ide_fixstring(fw_rev, 6, 0);
> =20
> +	fw_rev[4] =3D '\0';
> +	vendor_id[8] =3D '\0';
> +	product_id[16] =3D '\0';
> +
>  	printk(KERN_INFO "ide-tape: %s <-> %s: %s %s rev %s\n",
>  			drive->name, tape->name, vendor_id, product_id, fw_rev);

    This is not quite correct way to tackle this.  More correct would b=
e to=20
fix the format specifiers in this printk() to only print no more than N=
 string=20
characters like this:

  	printk(KERN_INFO "ide-tape: %s <-> %s: %.8s %.16s rev %.4s\n",
  		drive->name, tape->name, vendor_id, product_id, fw_rev);

MBR, Sergei
