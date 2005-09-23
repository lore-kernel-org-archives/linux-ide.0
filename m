From: Ric Wheeler <ric@emc.com>
Subject: Re: SATA Drive Information (vs hdparm -i)?
Date: Thu, 22 Sep 2005 21:16:05 -0400
Message-ID: <43335755.501@emc.com>
References: <7744a2840509221206254d2109@mail.gmail.com>	 <43334AFF.8010901@torque.net>	 <Pine.LNX.4.58.0509221729480.6613@shark.he.net> <7744a28405092218012aa90cd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:54728 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751081AbVIWBQL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Sep 2005 21:16:11 -0400
In-Reply-To: <7744a28405092218012aa90cd0@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Bollinger <rabollinger@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org

Richard Bollinger wrote:

>I'm specifically looking for something that will reveal the serial
>number of each SATA drive.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  
>
hdparm (modified to run against libata SCSI drives) does show the serial 
number:

[root@c001n01 root]# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       Maxtor 6B300S0
        Serial Number:      B60J1DTH
        Firmware Revision:  BANC1B70

