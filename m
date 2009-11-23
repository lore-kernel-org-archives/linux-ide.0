From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: Not able to set DMA mode other than default using hdparm
Date: Mon, 23 Nov 2009 22:28:41 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6D66E3C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46405 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbZKWQ6m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2009 11:58:42 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nANGwk6f026028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 23 Nov 2009 10:58:48 -0600
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Pedanekar, Hemant" <hemantp@ti.com>

Hello,

I am getting following error when trying to set DMA transfer mode as UD=
MA2 on latest DaVinci (DM6467) git kernel using hdparm (9.27 or older):

# ./hdparm -d1 -Xudma2  /dev/hda
/dev/hda:hda: UDMA/66 mode selected
 setting using_dma to 1 (on)
hda: UDMA/66 mode selected
 setting xfermode to 66 (UltraDMA mode2)
 HDIO_DRIVE_CMD(setxfermode) failed: Invalid argument
 using_dma     =3D  1 (on)

It seems DMA mode setting other than the default mode returns this erro=
r. That is, if I use "-Xudma4" in above command it returns success as U=
DMA4 is the default mode on DM6467.

I made following change which allows hdparm to set any supported DMA mo=
de. Can anyone confirm if this is a hdparm compatibility (incorrect use=
 of ioctl?) or the patch below indeed fixes the issue?

diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index d3440b5..6e7ae2b 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -162,7 +162,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsign=
ed long arg)
        if (tf->command =3D=3D ATA_CMD_SET_FEATURES &&
            tf->feature =3D=3D SETFEATURES_XFER &&
            tf->nsect >=3D XFER_SW_DMA_0) {
-               xfer_rate =3D ide_find_dma_mode(drive, XFER_UDMA_6);
+               xfer_rate =3D ide_find_dma_mode(drive, tf->nsect);
                if (xfer_rate !=3D tf->nsect) {
                        err =3D -EINVAL;
                        goto abort;


Thanks.
-
Hemant
=A0

