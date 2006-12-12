From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems with controllers SATA chipset SIS
Date: Tue, 12 Dec 2006 09:27:03 +0900
Message-ID: <457DF757.5060504@gmail.com>
References: <1165860002.5304.2.camel@ka029.kachan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:7267 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbWLLA1L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 19:27:11 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1729514wxd
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 16:27:10 -0800 (PST)
In-Reply-To: <1165860002.5304.2.camel@ka029.kachan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fernando Faria Mariano <cpd@kachan.com.br>
Cc: linux-ide@vger.kernel.org

Fernando Faria Mariano wrote:
> Dec  2 02:26:11 localhost kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> Dec  2 02:26:11 localhost kernel: sda: Write Protect is off
> Dec  2 02:26:11 localhost kernel: sda: Mode Sense: 00 3a 00 00
> Dec  2 02:26:11 localhost kernel: SCSI device sda: drive cache: write back
> Dec  2 02:28:32 localhost kernel: ata1.00: exception Emask 0x12 SAct 0x0 SErr 0x700401 action 0x2

SErr 0x700401 is...

ERR.I	: Recovered data integrity error
ERR.P	: Protocol error
DIAG.H	: Handshake error
DIAG.C	: CRC error
DIAG.D	: Disparity error

So, you're suffering frequent transmission errors (not media).  The
probable causes are...

* Wrong cabling (faulty cable, bad contacts)
* Power fluctuation or other electromagnetic interference
* Faulty hardware (controller and/or drive)

Try to...

* Reconnect whole thing.
* Swap cables.
* Swap drives.
* Swap controller ports.
* Swap power connectors.

-- 
tejun
