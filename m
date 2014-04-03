From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SATA link issue with Marvell 9170
Date: Wed, 02 Apr 2014 23:10:10 -0600
Message-ID: <533CED32.8060906@gmail.com>
References: <26AEAD365CFA784DA33319947CEB5DF86201255F@USCAEXCH1.tad.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:55979 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616AbaDCFKN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2014 01:10:13 -0400
Received: by mail-ig0-f179.google.com with SMTP id hl10so1328360igb.0
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2014 22:10:12 -0700 (PDT)
In-Reply-To: <26AEAD365CFA784DA33319947CEB5DF86201255F@USCAEXCH1.tad.internal.tilera.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Biji John <bjohn@tilera.com>, "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 01/04/14 03:17 PM, Biji John wrote:
> Tejun,
>
> I'm running into an intermittent issue while trying to run one of our boards. It has the Marvell 9170 SATA controller connected to one of our PCIe buses. On the other side is an MSATA device. I'm running kernel 3.4.76. Intermittently, the link will not come up, it looks like the driver tries to bring the link up at 3Gbps, and then eventually fails, and the kernel will hang waiting for the root device. From doing a Google search, I noticed that this version of the ahci driver does not have the entries for 9170 (and 9178) in ahci_pci_tbl. Is this expected behavior? After adding the following patch, I'm seeing improvement, and am wondering how the patch might be helping in this regard.
>
>          { PCI_DEVICE(0x1b4b, 0x9170),
>            .driver_data = board_ahci_yes_fbs },                  /* 88se9170 */

Are you sure this is actually having a consistent effect? Relative to 
the default AHCI behavior that you'd be getting without out it, all this 
does is enable FIS-based switching, which should only make any 
difference if you had a port multiplier connected. That does result in 
the FBS enable bit being set for the port, but it seems odd that this 
would be fixing something.
