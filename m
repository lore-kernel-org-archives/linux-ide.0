From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [Patch] Make suspend/resume work with ich chipset in force AHCI
 mode
Date: Wed, 16 Feb 2011 14:27:24 +0300
Message-ID: <4D5BB49C.5060609@ru.mvista.com>
References: <20110216090709.GR5778@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60653 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab1BPL2m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2011 06:28:42 -0500
Received: by bwz15 with SMTP id 15so503613bwz.19
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2011 03:28:41 -0800 (PST)
In-Reply-To: <20110216090709.GR5778@Redstar.dorchain.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joerg Dorchain <joerg@dorchain.net>
Cc: linux-ide@vger.kernel.org

Hello.

On 16-02-2011 12:07, Joerg Dorchain wrote:

> Hello all,

> this patch in needed in addition to the previous one make
> suspend/resume work in the forced ahci mode.

    This remark should probably follow --- tear line (after the signoff).

> During resume from suspend to ram, the kernel pci layer restores
> the registers for the SATA controller once, then says okay, and
> sets dev->state_saved = false. However, since the restore goes
> from highest address (the BARs [base address registers]) to
> lowest register, some of the higher registers are set as RO
> because according to the lower registers controller is in PIIX
> mode.  This patch introduces a workaround for
> this problem, hacking around the PCI API by setting
> pdev->state_saved = true
> before we do the restore, basically leaving the pci config space
> untouched.

> Bye,

> Joerg

    "Hello" and "bye" shouldn't be the part of the patch description.

> Signed-off-by: joerg Dorchain<joerg@dorchain.net>

    Need space before the email address.

WBR, Sergei
