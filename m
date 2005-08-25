From: "Carlos Pardo" <Carlos.Pardo@siliconimage.com>
Subject: RE: sata_sil + UDMA CRC errors
Date: Thu, 25 Aug 2005 08:00:26 -0700
Message-ID: <2E9B8131C44AF746B1E06BF9B15A434B045D7FAB@zima.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.siimage.com ([12.24.47.101]:24080 "EHLO mail.siimage.com")
	by vger.kernel.org with ESMTP id S1751053AbVHYO55 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Aug 2005 10:57:57 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuri Kirsanov <flash@rccb.ru>, Alexander Shaposhnikov <shaposh@isp.nsc.ru>, linux-ide@vger.kernel.org, Paul Taylor <Paul.Taylor@siliconimage.com>
Cc: lbattraw@insightbb.com, jgarzik@pobox.com, htejun@gmail.com

Paul,

Are there any issues with the ASUS K8N-DL board that you recall ?

Carlos

-----Original Message-----
From: Yuri Kirsanov [mailto:flash@rccb.ru]
Sent: Thursday, August 25, 2005 7:04 AM
To: Alexander Shaposhnikov; linux-ide@vger.kernel.org
Cc: Carlos Pardo; lbattraw@insightbb.com; jgarzik@pobox.com; htejun@gmail.com
Subject: Re: sata_sil + UDMA CRC errors


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


