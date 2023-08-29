Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA82FC71153
	for <linux-ide@archiver.kernel.org>; Tue, 29 Aug 2023 14:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjH2Ocr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 29 Aug 2023 10:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbjH2OcU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2023 10:32:20 -0400
Received: from srv.wefi.net (srv.wefi.net [80.66.63.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90AFB109
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2023 07:32:16 -0700 (PDT)
Received: from [10.1.199.83] (unknown [91.223.201.11])
        by srv.wefi.net (Postfix) with ESMTPSA id 16D985A3586;
        Tue, 29 Aug 2023 16:32:15 +0200 (CEST)
Message-ID: <c42c50a63c3b35e3d87daca7b77edd87e1e92819.camel@wefi.net>
Subject: Re: [PATCH] ata: Add Elkhart Lake AHCI controller
From:   Werner Fischer <devlists@wefi.net>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Date:   Tue, 29 Aug 2023 16:32:07 +0200
In-Reply-To: <ZO3s6Sx8mCJwXWnX@x1-carbon>
References: <7728fa4b6027269d468f6a0665017c187471a9cd.camel@wefi.net>
         <a74207b7-64e9-c01c-ee9a-5269c6be41af@kernel.org>
         <f4f02b8d2aa8afd83c305589f576539a20e11c13.camel@wefi.net>
         <ZO3s6Sx8mCJwXWnX@x1-carbon>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, 2023-08-29 at 13:04 +0000, Niklas Cassel wrote:
> Considering the big mess that was introduced the last time we tried
> to enable LPM in an Intel AHCI controller, see:
> 104ff59af73a ("ata: ahci: Add Tiger Lake UP{3,4} AHCI controller")
> and
> 6210038aeaf4 ("ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4}
> AHCI controller"")
> 
> This patch makes me feel quite uncomfortable.

For Tiger Lake I think the problems could be related to the chipset or
BIOS.
The "Intel 500 Series Chipset Family Platform Controller Hub (PCH)"
Spec Update https://cdrdv2.intel.com/v1/dl/getContent/635220 
mentions the following update on page 20:
"BIOS should set this bit to 0 as APST is not supported."
So maybe older BIOS version have this bit set to 1, which may cause
issues?

> Yes, an AHCI controller should be able to have LPM enabled, but in
> reality there are so many SATA devices with broken LPM support, that
> we would need to add hundreds of quirks for all the broken devices.
In the error reports regarding Tiger Lake at least two different SSDs
are mentioned:
"Netac SSD 1TB"
https://bbs.archlinux.org/viewtopic.php?pid=2087227#p2087227
"SATA 3 drive (Samsung)"
https://bbs.archlinux.org/viewtopic.php?pid=2087334#p2087334

Currently, I'm not aware of Samsung drives having issues with LPM, but
of course I could be missing something here. Unfortunately, the posting
above does not state which Samsung drive it is.

With my Elkhart Lake test system, I have tested the following Samsung
drives successfully: 850 PRO, PM893
https://www.thomas-krenn.com/en/wiki/SATA_Link_Power_Management#Example_LES_v4

> Yes, one problem is that you need to use the board_ahci_low_power in
> order for the LPM polcies to apply. But it feels to me that accepting
> such a change is too intrusive (because of the distros default of LPM
> policy 3).
There are already many SATA controllers marked as
"board_ahci_low_power", including Bay Trail, Apollo Lake, Comet Lake
PCH-U (I have testsystem of these three platforms, LPM is working
without issues here for me).
So I'm not sure whether it is the SATA devices (drives) or chipsets
having issues in the wild.

Where I have seen issues on the other hand are cases, when a SATA
controller is used for different platforms as mentioned here:
https://www.spinics.net/lists/linux-ide/msg63375.html

1527f69204fe ("ata: ahci: Add Green Sardine vendor ID as board_ahci_mobile")
has set 0x7901 as board_ahci_mobile.
As this SATA controller is also used in EPYC servers, SATA Hot-Plug is
not working e.g. in Ubuntu by default (because the distro defaults to
LPM policy 3):
https://www.thomas-krenn.com/en/wiki/AMD_EPYC_Server_with_Ubuntu_-_Enable_SATA_Hot-Swap
Maybe including additional code which helps to distinguish whether it's
a mobile system or server system with hot-swap could help here.

> If we somehow had a way where regular users are less affected...
> E.g. if there was a way to try to link up with LPM enabled in the
> AHCI controller by default, but if it fails X amount of times, then
> we disable LPM in the controller (or maybe try to set policy to
> ATA_LPM_MAX_POWER).
> Kind of like how we do for link speed, where we try a lower link
> speed on the final attempt to establish a link:
> https://github.com/torvalds/linux/blob/v6.5/drivers/ata/libata-eh.c#L3599
> 
> Another option might be to do the opposite.. Establish a link with
> LPM disabled (or maybe with policy set to ATA_LPM_MAX_POWER), if we
> can establish a link, make a record of it, and then enable LPM and
> reset the drive.
> If we can't establish a link with LPM enabled, and we have a record
> that the link was established without LPM, disable LPM again and
> reset the drive.
> 
> Not sure which is most feasible to implement.
Thank you very much for your ideas and your time.
I will think about them (although I'm not capable of coding such
changes).

I may give further feedback in the upcoming days.
Maybe other developers have input in here, too.

Kind regards,
Werner
