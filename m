From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: ICH8 and SATA
Date: Tue, 23 May 2006 10:12:53 +0800
Message-ID: <44726FA5.4090407@tw.ibm.com>
References: <447169C8.9060708@garzik.org> <44723571.1090500@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:36318 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751250AbWEWCNE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 May 2006 22:13:04 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4N2D2Ka013629
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 22:13:02 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4N2D2Xb206822
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 20:13:02 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4N2D1ji013207
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 20:13:02 -0600
In-Reply-To: <44723571.1090500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> BTW, Intel sez:
>>
>> "FYI, I added PIIX_FLAG_IGNORE_PCS and was able to boot on ICH8."
>>
> 
> Yeap, that should achieve about the same effect as the experimental
> patch Andrew posted; also, about the same phantom bug.
> 
> I don't think the phantom device problem is caused by missing
> dev_select.  We have enough dev_select() during classification.
> 

Yes, I cannot find missing dev_select(), neither.

It seems the Intel chip is emulating the PATA master/slave
behavior and reproduces the phantom slave problem of PATA.

>From the ATA-4 spec:
(http://t13.org/project/d1153r18-ATA-ATAPI-4.pdf)

Section 9.16 said: in single master configuration, the master should
response for slave, if the slave is inexistent.
=> The software sees the illusion faked by the master device.

Later in ATA-6 spec, section 9.16 is updated:  for ATAPI devices,
the master should response for slave with 0x00 taskfile,
if the slave if inexistent. However, some device doesn't follow the
new spec...

--
albert

Excertp from the ATA-4 spec:

9.16 Single device configurations

9.16.1 Device 0 only configurations

In a single device configuration where Device 0 is the only device and
the host selects Device 1, Device 0 shall respond as follows:
1) A write to the Device Control register shall complete as if Device 0 was the selected device;
2) A write to a Command Block register, other than the Command register, shall complete as if
Device 0 was selected;
3) A write to the Command register shall be ignored, except for EXECUTE DEVICE DIAGNOSTIC;
4) A read of the Control Block or Command Block registers, other than the Status or Alternate
Status registers, shall complete as if Device 0 was selected;
5) A read of the Status or Alternate status register shall return the value 00h.

NOTE - Even though Device 1 is not present, the register content may appear valid for
Device 1. Further means may be necessary to determine the existence of Device 1, e.g.,
issuing a command.

9.16.2 Device 1 only configurations


