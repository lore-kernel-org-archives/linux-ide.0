From: Mark Lord <mlord@pobox.com>
Subject: Re: Marvell 7042 has some problem on Marvell 6281(kirkwood) platform
 (Resent)
Date: Tue, 21 Jul 2009 22:53:52 -0400
Message-ID: <4A667F40.8060309@pobox.com>
References: <788014650907211910j443d4d31y88001319acf8c1d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbZGVCx5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jul 2009 22:53:57 -0400
In-Reply-To: <788014650907211910j443d4d31y88001319acf8c1d4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khchen@synology.com
Cc: Tejun Heo <htejun@gmail.com>, saeed@marvell.com, linux-ide@vger.kernel.org

KueiHuan Chen wrote:
> Dear Mark,
> 
>   Sorry for the incorrect mail format, so i resent it again.
> 
>   Here has a problem when we put the 7042 on the kirkwood
> platform(6281). When system starting to build software raid 5,
> sometimes it would meet the unable to stop eDMA problem in all
> channels.  And then whole system is being hang ...  All the phy mode
> value are also not correctly if we read it out at that time.
..

Are you using a discrete 7042 chip on a PCIe bus
along with a 6281 chip ??  

Or are you simply using the built-in SATA controller inside the 6281 ?

In either event, Marvell did not deem to share *any* technical info
about the 6281 with me, so I really cannot help you.

Saeed Bishara from Marvell did everything to do with that chip.

>   Could you please kindly have a look at the error messages and give
> some advice for me to find out the root cause ? Thanks.
> 
> Thanks again.
> -------------
> ata4: Unable to stop eDMA
> ata4.00: exception Emask 0x52 SAct 0x1f SErr 0xffffffff action 0xe frozen
> ata4: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt
> PHYRdyChg PHYInt CommWake 10B8B Dispar BadCRC Handshk LinkSeq
> TrStaTrns UnrecFIS DevExch }
> ata4.00: cmd 61/e0:00:c7:26:4f/01:00:01:00:00/40 tag 0 ncq 245760 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
..

I think the messages that happened before those above are the important ones,
and you did not show those messages here.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
