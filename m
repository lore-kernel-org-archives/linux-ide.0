From: Richard Scobie <r.scobie@clear.net.nz>
Subject: Port multiplier
Date: Mon, 28 Aug 2006 19:16:31 +1200
Message-ID: <44F2984F.6030100@clear.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sauce.co.nz ([210.48.49.72]:32223 "EHLO smtp.sauce.co.nz")
	by vger.kernel.org with ESMTP id S932364AbWH1HRD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2006 03:17:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi Tejun,

I am about to start experimenting with SATA PMP and have spent some time
on the net collecting information, including your WIKI.

Please can you help me with a few of missing bits.

I have ordered an ASUS M2N SLI Deluxe which in addition to the NVIDIA
SATA controller, has a JMicron 363 SATA controller which handles one
internal SATA connector and an external eSATA connector.

My understanding is that the JMicron will work using kernel AHCI support
and the board BIOS has an AHCI setting.

My hope is to be able to connect an Addonics AD5APM-E 5 disk port
multiplier module to this. From the photo and some other information at
their website, this appears to use either a Silicon Image 3124 or 3132 chip.

Do you think this will work, if I use the current patch 20060710 on your
Wiki?

If so, and it supports hotplugging, which I believe it may do, what
exactly does this mean?

Can I power up an external enclosure containing the Addonics and 3
drives, configured as a RAID 5 and plug it straight into the running system?

If so, can this be set up to mount automatically?

Can I unmount the connected and mounted array and just unplug the array
with no further concern?

I hope I have not wasted your time by asking this. If the information is
elsewhere, please let me know.

Kind regards,

Richard Scobie


