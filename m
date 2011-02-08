From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ahci: recognize Marvell 88se9125 PCIe SATA 6.0 Gb/s controller
Date: Tue, 08 Feb 2011 15:14:29 +0300
Message-ID: <4D5133A5.8090808@ru.mvista.com>
References: <4D5107D3.7030509@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42959 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772Ab1BHMPp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 07:15:45 -0500
Received: by bwz15 with SMTP id 15so5945045bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 08 Feb 2011 04:15:44 -0800 (PST)
In-Reply-To: <4D5107D3.7030509@computer.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Per Jessen <per@computer.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

On 08-02-2011 12:07, Per Jessen wrote:

> Hi Jeff

    This shouldn't be the part of the changelog.

> Below is a minor patch for drivers/ata/ahci.c for recognising
> Marvell 88SE9125 PCIe SATA 6.0 Gb/s controller as found on the
> RocketRaid 62X controller series. I have also submitted updates
> to pci-ids.

> Signed-off-by: Per Jessen <per@computer.org>

> --- a/drivers/ata/ahci.c 2011-02-02 14:55:16.514999946 +0100
> +++ b/drivers/ata/ahci.c 2011-02-01 14:01:00.380977830 +0100
> @@ -380,6 +380,8 @@
> { PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv }, /* 6121 */
> { PCI_DEVICE(0x1b4b, 0x9123),
> .driver_data = board_ahci_yes_fbs }, /* 88se9128 */
> + { PCI_DEVICE(0x1b4b, 0x9125),
> + .driver_data = board_ahci_yes_fbs }, /* 88se9125 */

    Your patch has spaces instead of all tabs.

WBR, Sergei
