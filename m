Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EDC4332F
	for <linux-ide@archiver.kernel.org>; Sun,  4 Dec 2022 21:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLDVqs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 4 Dec 2022 16:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDVqr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 4 Dec 2022 16:46:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B42FD1A
        for <linux-ide@vger.kernel.org>; Sun,  4 Dec 2022 13:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 007AD60F0C
        for <linux-ide@vger.kernel.org>; Sun,  4 Dec 2022 21:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E0CC433C1;
        Sun,  4 Dec 2022 21:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670190405;
        bh=1LQeNf4M8MAiLqkKUdRILYAay8xYd3z0n7IhAO+DNdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgbR/RvZz82QCRSLxoPof+13l0ZOzJbIPJe4hNxvjKUtWeW3z/TmO0ZgFJJ/EZGgr
         12a+4lRumct5KMor72voXzZxhh1j/CUwXKnAPYLiQAHXDHYDYHsy7u3iDUx1PpHszo
         op/BssZUfXeCUDNZxD9T3FeDW+ViLCBM7yemnnX3Tu/JoPxDA4SnidaxiHURdqtbL4
         jbY18LDp8Pwj/vVeE9y1ie8pJsgZG6meU63MFWTPFg+Ter2AqRoTDYnDac+lCk6biP
         BABCSjz2KKeC0sG73gMoJSP3MvVHQdsF4grzP4tegA+SYTnrlV2Lb5r5K2sLKqDtri
         ILS4m1U61HyfA==
Received: by pali.im (Postfix)
        id 48DE4949; Sun,  4 Dec 2022 22:46:42 +0100 (CET)
Date:   Sun, 4 Dec 2022 22:46:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     marius@psihoexpert.ro
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Subject: Re: Bug report for ahci-mvebu driver
Message-ID: <20221204214642.l5ktscfrfxbxo5in@pali>
References: <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <ed1841a08205d417e2e9866479878b29@psihoexpert.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed1841a08205d417e2e9866479878b29@psihoexpert.ro>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sunday 04 December 2022 21:14:14 marius@psihoexpert.ro wrote:
> December 4, 2022 12:23 PM, "Pali Rohár" <pali@kernel.org> wrote:
> 
> >> What next? Should I contact David Milburn <dmilburn@redhat.com> (the commit author) and ask for a
> >> better fix?
> > 
> > That is a good idea.
> 
> I think I'll wait for an opinion from Damien. Since the same libata-core.c works perfectly fine with sata-mv driver, but not ahci-mvebu, the problem might still be in the ahci-mvebu.

That is also possible. But existence of a38x sata specific errata smells.

> The comment said: "sata_down_spd_limit should return if driver has not recorded sstatus speed". This probably means that ahci-mvebu does not record the expected "sstatus speed". I don't know what that is, but Damien probably does.

Lets wait for Damien.

Also note that in kernel ahci_mvebu.c driver code is custom function
ahci_mvebu_stop_engine where is description of another Errata Ref#226 -
SATA Disk HOT swap issue when connected through Port Multiplier in
FIS-based Switching mode.

This errata is documented _only_ for A3720 (not A38x/A39x) but is
installed for all mvebu platforms. So I'm not sure if this is not
another kernel bug and code should be adjusted to _not_ install
ahci_mvebu_stop_engine for a38x/a39x.

> >> @ Pali Rohar:
> >> I could't find the errata you mentioned. If you have it, please take a look at the commit above and
> >> see if it is affected in any. Thanks.
> > 
> > I do not have more details than what I already wrote in previous email.
> > 
> > Errata documents are in most cases available on Marvell Customer Portal.
> > You need to register for accessing them. https://www.marvell.com/portal
> > 
> > Documents which were available publicly without registration are here:
> > https://www.kernel.org/doc/html/latest/arm/marvell.html
> > (errata for a38x was not publicly available)
> 
> There is a slim chance that I could understand them. I'm just an amateur. I did some bare-metal programming on MCUs, but the kernel is way too complicated for me.

Hehe... those documents lot of time contains incomplete or ambiguous
statements and also professionals cannot understand them...

As I wrote in previous email, errata Ref #: FE-8889968 just says:
Due to the wrong Busy status returned, the GEN 1.0 Port Multiplier
cannot establish a link with the SATA 3.0 interface. As a workaround
connect GEN 1.0 Port Multiplier to a SATA 2.0 interface.

And I'm not SATA expert too. Lets wait for Damien.
