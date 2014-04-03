From: Biji John <bjohn@tilera.com>
Subject: RE: SATA link issue with Marvell 9170
Date: Thu, 3 Apr 2014 05:48:18 +0000
Message-ID: <26AEAD365CFA784DA33319947CEB5DF862012BD5@USCAEXCH1.tad.internal.tilera.com>
References: <26AEAD365CFA784DA33319947CEB5DF86201255F@USCAEXCH1.tad.internal.tilera.com>,<533CED32.8060906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uscamail.tilera.com ([12.218.212.166]:36756 "EHLO
	USCAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161986AbaDCFsT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2014 01:48:19 -0400
In-Reply-To: <533CED32.8060906@gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>, "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

It seems to be having a consistent effect so far. I'm running boot-up iterations now to see how well it holds up, and will keep running it for a few days. I'm wondering if the difference in behavior might be due to an indirect delay in the code flow that might be giving the link additional time to come up. 

Also, I ran another set of experiments with the following mod in ata_wait_ready(), and that held up as well. Interestingly, I saw the link come up at a reduced speed intermittently (3 and 1.5).

                //ata_msleep(link->ap, 50);
                ata_msleep(link->ap, 500);

I'll also run the libata.force experiment that Tejun suggested.

Thanks.
-Biji
 
________________________________________
From: Robert Hancock [hancockrwd@gmail.com]
Sent: Wednesday, April 02, 2014 10:10 PM
To: Biji John; tj@kernel.org
Cc: linux-ide@vger.kernel.org
Subject: Re: SATA link issue with Marvell 9170

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
