From: "Yuri Kirsanov" <flash@rccb.ru>
Subject: Re: sata_sil + UDMA CRC errors
Date: Thu, 25 Aug 2005 18:03:54 +0400
Message-ID: <006701c5a97d$d4311600$6f0aa8c0@rgkb.local>
References: <1124977997.2949.13.camel@m00>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.85.106.102] ([213.85.106.102]:62687 "EHLO rccb.ru")
	by vger.kernel.org with ESMTP id S964996AbVHYOBQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2005 10:01:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shaposhnikov <shaposh@isp.nsc.ru>, linux-ide@vger.kernel.org
Cc: Carlos.Pardo@siliconimage.com, lbattraw@insightbb.com, jgarzik@pobox.com, htejun@gmail.com

I have exactly the same problem with Silicon controller...

----- Original Message -----
From: "Alexander Shaposhnikov" <shaposh@isp.nsc.ru>
To: <linux-ide@vger.kernel.org>
Cc: <Carlos.Pardo@siliconimage.com>; <lbattraw@insightbb.com>;
<jgarzik@pobox.com>; <htejun@gmail.com>
Sent: Thursday, August 25, 2005 5:53 PM
Subject: sata_sil + UDMA CRC errors


> Good time of the day.
> I think this might be a bug in sata_sil driver.
>
> I have ASUS K8N-DL board with onborad sil3114 controller. As support for
> nVidia Nforce 2200 SATA is broken in current sata_nv driver, i have to
> use sil3114. Kernel is 2.6.13-rc6 + "sata_sil Mod15Write
> quirk workaround" patch of TeJun Heo. OS is Fedora4 x86_64
>
> There are two SATA drives, Seagate 7200.7 160Gb and Samsung SP0812C
> 80Gb.
>
> Here is the problem:
> Any intensive read/write activity results in alot of UDMA CRC errors for
both drives.
> I am getting :
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x04 { DriveStatusError }
> kernel messages. With the patch applied, error rate is significantly low
> for Seagate drive; Samsung is still virtually unusable.
> I checked SMART attributes, and the count of  UDMA CRC errors is ~200
> for Seagate and more than 1000 for Samsung. Every time i get new
> "status=0x51" errors for any drive, number of UDMA CRC errors grow
> accordingly.
>
> But there seems to be no problems under Windows. Even highest read/write
> activity do not generate any new CRC errors.
>
> Sorry for bad english.
>
> Best Regards,
> Alexander Shaposhnikov
>
>
>
>
>
>
>
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


