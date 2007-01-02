From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: A question to Uwe Koziolek (raid on sis180)
Date: Tue, 02 Jan 2007 23:36:30 +0100
Message-ID: <459ADE6E.4020303@gmx.net>
References: <459A1D09.000001.14988@tide.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965010AbXABWgm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 17:36:42 -0500
In-Reply-To: <459A1D09.000001.14988@tide.yandex.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rmanzhos@yandex.ru
Cc: linux-ide@vger.kernel.org

>
> Hello.
> Could you help me with such a question.
> A have sis180 and raid0 on two sata disks. In windows all works: simply give it a driver and I have access to the raid like to an ordinary disk (nothing to think about). But when I try linux, I obtain two disks (sdb and sdc, for exaple) and interestingly on one disk I can "see" (I mean dmesg output) 3 partitions (sdb1, sdb2 and sdb3) and on the other  - 2 (sdc1, sdc2) - in windows I partitioned the disk on 3 partitions. I tried the driver from sis.com (sis18x_20060508.zip). As I understood the sata_sis from sis.com is the same or almost the same as in kernel tree (I've tried 2.6.11). Then I looked at dmraid - it supports a lot of fakeraids, but not the sis:( I thought about software raid, but this frights me:)
> And now the question: is there any posibility to obtain acces to my raid0-disk in linux or would I better find different problem to solve:)
>   
Actually I have no information for the SiS software raid. But it is a 
good idea to support this using dmraid. I can try a support of this 
controller in dmraid,
but it takes some time.

regards,
Uwe Koziolek




