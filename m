From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Fwd: [BUG] sata_via doesn't detect anymore my disks (broken
 between rc1 and rc3)]
Date: Fri, 25 Aug 2006 21:16:41 +0900
Message-ID: <44EEEA29.1010008@gmail.com>
References: <44D98E7E.3060208@pobox.com> <44E29AEF.8030606@gmail.com>	<20060816051408.GI6371@htj.dyndns.org>	<m2wt98bio1.fsf@vador.mandriva.com> <m2sljwbil7.fsf@vador.mandriva.com>	<44E37BD4.8010709@pobox.com> <m23bbva9cs.fsf@vador.mandriva.com>	<44E46E0E.4060703@gmail.com> <m2fyfv7a8s.fsf@vador.mandriva.com>	<44EB32AD.1080305@gmail.com> <m2fyfnciky.fsf@vador.mandriva.com> <m2d5aprtw0.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:60624 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750724AbWHYMQs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 08:16:48 -0400
Received: by py-out-1112.google.com with SMTP id n25so1215757pyg
        for <linux-ide@vger.kernel.org>; Fri, 25 Aug 2006 05:16:47 -0700 (PDT)
In-Reply-To: <m2d5aprtw0.fsf@vador.mandriva.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Thierry Vignaud wrote:
> Thierry Vignaud <tvignaud@mandriva.com> writes:
> 
>>> Can you please test two patches attached in this mail?  Just quick
>>> result will be enough.  If both don't work, I'll go ahead and
>>> create a third one - which emulates the old phy hardreset exactly
>>> as I did for softreset of vt6420.
>> I'll.
>>
>> As, I've tested that using:
>> - ata_std_prereset + ata_std_softreset didn't work
>> - vt6420_prereset + ata_std_softreset worked
>> - vt6420_prereset w/o ata_std_softreset didn't work
>>
>> I simple interdiff between your two patches makes me think the odds're
>> higher the second will succeed but you've done some extra changes
>> since your previous patch.
>> I'll you tell you more about this tomorrow.
> 
> none of both these patches worked :-(

The second didn't work?  But you said the following one liner worked.

--- drivers/ata/sata_via.c.tv6	2006-08-20 16:37:41.000000000 +0200
+++ drivers/ata/sata_via.c	2006-08-20 17:20:23.000000000 +0200
@@ -244,7 +244,7 @@

  static void vt6421_error_handler(struct ata_port *ap)
  {
-	return ata_bmdma_drive_eh(ap, ata_std_prereset, NULL,
+	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
  				  sata_std_hardreset, ata_std_postreset);
  }

The second patch is essentially identical to what you did the one liner. 
  Can you please check it once more?  I'll prepare old-sequence 
hardreset in the meantime.

Thanks.

-- 
tejun
