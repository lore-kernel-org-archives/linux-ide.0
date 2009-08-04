From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Extremely slow IO with a PCMCIA CompactFlash adapter
Date: Tue, 4 Aug 2009 12:54:08 +0200
Message-ID: <200908041254.08315.bzolnier@gmail.com>
References: <h51hro$p6j$1@ger.gmane.org> <200908022027.18937.bzolnier@gmail.com> <cdb43e8a0908021825y7d029614pffad28e6dd70f04c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932753AbZHDKzX@vger.kernel.org>
In-Reply-To: <cdb43e8a0908021825y7d029614pffad28e6dd70f04c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jack Byer <ojbyer@usa.net>
Cc: linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andreas Mohr <andi@lisas.de>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 03 August 2009 03:25:18 Jack Byer wrote:
> >
> > Seems like there is also a bug in ali5451 sound driver..
> >
> > This should help:

[...]

> Those patches do not appear to have worked:

My bad, jiffies checks need to be reversed now (corrected patch attached)..

Please also post output of dmidecode command -- we may try to workaround
the issue by not using IRQ mode in pata_pcmcia for this particular system
and resorting to libata's polling mode instead..

---
 sound/pci/ali5451/ali5451.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: b/sound/pci/ali5451/ali5451.c
===================================================================
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -314,8 +314,11 @@ static int snd_ali_codec_ready(struct sn
 		res = snd_ali_5451_peek(codec,port);
 		if (!(res & 0x8000))
 			return 0;
+		if (!time_after_eq(end_time, jiffies))
+			break;
 		schedule_timeout_uninterruptible(1);
-	} while (time_after_eq(end_time, jiffies));
+	} while (1);
+
 	snd_ali_5451_poke(codec, port, res & ~0x8000);
 	snd_printdd("ali_codec_ready: codec is not ready.\n ");
 	return -EIO;
@@ -327,15 +330,17 @@ static int snd_ali_stimer_ready(struct s
 	unsigned long dwChk1,dwChk2;
 	
 	dwChk1 = snd_ali_5451_peek(codec, ALI_STIMER);
-	dwChk2 = snd_ali_5451_peek(codec, ALI_STIMER);
 
 	end_time = jiffies + msecs_to_jiffies(250);
 	do {
 		dwChk2 = snd_ali_5451_peek(codec, ALI_STIMER);
 		if (dwChk2 != dwChk1)
 			return 0;
+		if (!time_after_eq(end_time, jiffies))
+			break;
 		schedule_timeout_uninterruptible(1);
-	} while (time_after_eq(end_time, jiffies));
+	} while (1);
+
 	snd_printk(KERN_ERR "ali_stimer_read: stimer is not ready.\n");
 	return -EIO;
 }
