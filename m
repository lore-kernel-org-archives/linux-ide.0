From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: libata Intel PIIX/ICH fails to detect both PATA drives, spews
 ACPI errors
Date: Tue, 13 Mar 2007 19:46:27 -0600
Message-ID: <45F753F3.1080102@gmail.com>
References: <45705618.2020608@gmail.com> <45E447DD.9050308@gmail.com> <45F3F8AA.4060501@gmail.com> <45F4FCA3.1080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:10133 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933651AbXCNBqu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 21:46:50 -0400
Received: by wr-out-0506.google.com with SMTP id i28so7155wra
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 18:46:50 -0700 (PDT)
In-Reply-To: <45F4FCA3.1080301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, Berck.
> 
> Berck E. Nash wrote:
>> Tejun Heo wrote:
>>> Berck E. Nash wrote:
>>>> Testing the new libata ICH PATA drivers.  There's one PATA port on this
>>>> chip, and I've got two optical drives connected to it.  The master drive
>>>> fails to detect.  The slave detects and works properly.
>>> Can you test 2.6.20.1 and post full dmesg?
>> Here's 2.6.20.2...  No ACPI errors, but still doesn't detect both drives.
> 
> Please apply the attached patch and see if it works.  If it works,
> please post the result of hdparm -I /dev/srX of the optical drive.  Thanks.
> 

Okay, here ya go:

/dev/sr0:

ATAPI CD-ROM, with removable media
        Model Number:       LITE-ON LTR-48246S
        Serial Number:
        Firmware Revision:  SS0E
Standards:
        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
        Supported: CD-ROM ATAPI-2
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(cannot be disabled)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=227ns  IORDY flow control=120ns


