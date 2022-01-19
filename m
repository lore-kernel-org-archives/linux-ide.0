Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FB1C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 19 Jan 2022 17:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347436AbiASR5I (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:57:08 -0500
Received: from woodpecker.gentoo.org ([140.211.166.183]:33272 "EHLO
        smtp.gentoo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346442AbiASR5I (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jan 2022 12:57:08 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id CC025343196
        for <linux-ide@vger.kernel.org>; Wed, 19 Jan 2022 17:57:06 +0000 (UTC)
Received: (qmail 4542 invoked by uid 10000); 19 Jan 2022 17:57:06 -0000
Date:   Wed, 19 Jan 2022 17:57:06 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 0/2][RFC] Make delay before debouncing configurable
Message-ID: <robbat2-20220119T172913-356389698Z@orbis-terrarum.net>
References: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
 <85153d62-15b6-e055-00aa-74b728bb0195@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85153d62-15b6-e055-00aa-74b728bb0195@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi, not originally in the thread, but I've run into hardware where the
delay was bumpy before, when I did early porting around SATA PMP code
(https://dev.gentoo.org/~robbat2/patches/libata-development/ if you want
to see really old patches from 2006)

This series esp of a code approach that didn't get merged might be
interesting, that implements hotplug by polling:
https://dev.gentoo.org/~robbat2/patches/libata-development/2007/00-hp-poll/

On Fri, Jan 14, 2022 at 06:23:26PM +0900, Damien Le Moal wrote:
> On 1/14/22 00:46, Paul Menzel wrote:
> > The 200 ms delay before debouncing the PHY was introduced for some buggy
> > old controllers. To decrease the boot time to come closer do instant
> > boot, add a parameter so users can override that delay.
> > 
> > The current implementation has several drawbacks, and is just a proof of
> > concept, which some experienced Linux kernel developer can probably
> > implement in a better way.
> I do not think that a libata module parameter is not the way to go with
> this: libata is used by all drivers, so for a system that has multiple
> adapters, different delays cannot be specified easily.
I think this is a key thing here; and I like that your patch moves to a
flag.

> I am really thinking that the way to go about this is to remove the
> 200ms delay by default and add it only for drivers that request it with
> a link flag. That is, ATA_LFLAG_NO_DEBOUNCE_DELAY needs to become
> ATA_LFLAG_DEBOUNCE_DELAY.
I agree that removing it by default is right, but I'd like to make one
additional request here:
Please add a libata.force= flag that lets users enable/disable the delay
per adapter/link.

I think this would be valuable to rule out issues where the debounce
delay is needed on the drive side more than the controller side, esp. in
cases of poorly implemented port multipliers as Tejun & I found back in
2006.

Maybe libata.force=X.Y:no_debounce_delay & libata.force=X.Y:force_debounce_delay

The ata_parse_force_one function as it stands can't handle a parameter
to the value, so you cannot get libata.force=X.Y:debounce_delay=N
without also improving ata_parse_force_one.

> The other large delay is the link stability check in
> sata_link_debounce(). 100ms is added (more for hotplug case) to ensure
> that the SStatus register DET field provides a stable value. But I
> cannot find any text in the AHCI and SATA IO specs that mandate such
> large delay.
Nice find!

> There are differences between the many HDDs & SSDs I have connected
> though. There is a lot of scheduling side effects at play, so the gains
> are variable in my case. A system with a single disk attached should be
> used for proper evaluation.
That gets likely single-disk worst/best case, but I'm still worried
about port multipliers (sadly I don't have the worst-implemented ones
anymore, I sold them to some Windows users)

-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
