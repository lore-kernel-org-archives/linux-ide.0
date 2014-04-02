From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: SATA link issue with Marvell 9170
Date: Wed, 2 Apr 2014 13:16:37 -0400
Message-ID: <20140402171637.GJ16631@htj.dyndns.org>
References: <26AEAD365CFA784DA33319947CEB5DF86201255F@USCAEXCH1.tad.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:53611 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbaDBRQk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2014 13:16:40 -0400
Received: by mail-qa0-f52.google.com with SMTP id m5so476801qaj.11
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2014 10:16:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <26AEAD365CFA784DA33319947CEB5DF86201255F@USCAEXCH1.tad.internal.tilera.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Biji John <bjohn@tilera.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Tue, Apr 01, 2014 at 09:17:35PM +0000, Biji John wrote:
> I'm running into an intermittent issue while trying to run one of
> our boards. It has the Marvell 9170 SATA controller connected to one
> of our PCIe buses. On the other side is an MSATA device. I'm running
> kernel 3.4.76. Intermittently, the link will not come up, it looks
> like the driver tries to bring the link up at 3Gbps, and then
> eventually fails, and the kernel will hang waiting for the root
> device. From doing a Google search, I noticed that this version of
> the ahci driver does not have the entries for 9170 (and 9178) in
> ahci_pci_tbl. Is this expected behavior? After adding the following
> patch, I'm seeing improvement, and am wondering how the patch might
> be helping in this regard.
> 
>         { PCI_DEVICE(0x1b4b, 0x9170),
>           .driver_data = board_ahci_yes_fbs },                  /* 88se9170 */

So, if the device doesn't have a specific entry, it'd use the default
board_ahci entry.  The only difference is whether FBS is turned on for
port multipliers.  The change that you made above is highly unlikely
to make any difference for initialing link init and probing.  Does it
work reliably with libata.force=1.5Gbps?

Thanks.

-- 
tejun
