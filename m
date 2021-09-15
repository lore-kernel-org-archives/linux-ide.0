Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38461C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 15 Sep 2021 16:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B97D60FC0
	for <linux-ide@archiver.kernel.org>; Wed, 15 Sep 2021 16:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhIOQqb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhIOQq1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Sep 2021 12:46:27 -0400
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Sep 2021 09:45:08 PDT
Received: from polyxena.technikum-wien.at (mail.technikum-wien.at [IPv6:2001:67c:1790:1d00::de])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DFFC061574
        for <linux-ide@vger.kernel.org>; Wed, 15 Sep 2021 09:45:07 -0700 (PDT)
Received: from legacy (80-109-83-31.cable.dynamic.surfer.at [80.109.83.31])
        by bifrost2.technikum-wien.at (Postfix) with ESMTPSA id 4H8m6H1MDbzRy1;
        Wed, 15 Sep 2021 18:35:19 +0200 (CEST)
Date:   Wed, 15 Sep 2021 18:35:18 +0200
From:   Stefan Tauner <tauner@technikum-wien.at>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-ide@vger.kernel.org
Subject: Re: Questions (and a possible bug) regarding the
 ata_device_blacklist and ATA_HORKAGE_ZERO_AFTER_TRIM
Message-ID: <20210915183518.0947de73@legacy>
In-Reply-To: <yq1pnjm1zvk.fsf@oracle.com>
References: <20190926150400.2524a63b@legacy>
        <yq1pnjm1zvk.fsf@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

sorry for the "small" delay... I got distracted and only now revisited
this topic as I wanted to use discard to improve backup space
efficiency and pondered on using devices_handle_discard_safely of the
raid456 module (I run ext4 on lvm on luks on raid5 on 3 ssds) since
otherwise I cannot trim at all.

My inquiry deals with two points:
 - Discussing the addition of ATA_HORKAGE_ZERO_AFTER_TRIM for Crucial
   CT500MX500 (or CT*MX500 to include the 250 GB, 1 TB and 2 TB models)
 - Determining why the Samsung SSD 860 EVO is not recognized to zero
   after trim

On Thu, 26 Sep 2019 18:01:03 -0400
"Martin K. Petersen" <martin.petersen@oracle.com> wrote:

> > I don't know the technical details how this is communicated by the
> > drive but I assume it's the same thing that smartctl and hdparm output
> > as "Model Number" and "Device Model" respectively.  
> 
> Yes.
> 
> > If this is correct (is it?) then there is a problem with the list
> > AFAICT because the Crucial SSD I have reports this field simply as
> > "CT500MX500SSD4" but the kernel expects "Crucial" at the beginning of
> > almost all Crucial drives (line 4523+) including the vendor wildcard at
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-core.c#n4586
> > Interestingly, in line 4520 there is an entry for the CT500BX100SSD1
> > that does not start with "Crucial".  
> 
> With a few exceptions, the entries in the libata white/blacklist were
> submitted by Crucial/Micron themselves. But it's possible that they
> changed their naming scheme.

I can look for some smartctl logs of similar models but it is obviously
the case for mine.

> > After looking into smartctl's drive database I guess the MX500 [2] (as
> > well as BX100, BX200, BX300 and BX500 [1]) series stand out in this
> > regard. This means that all of them do *not* get the
> > ATA_HORKAGE_ZERO_AFTER_TRIM flag set because they are not matched by
> > any of the model-specific entries nor the cumulative "Crucial*" vendor
> > entry.  
> 
> The newest drives I have are M550 models.

Since Crucial has stopped producing new models I think it makes sense
to eventually conclude this topic and make some (final?) changes if
need be. Apparently the queued trim issues are not fully figured out
yet (saw commits to Linus' tree a short while ago on that) - so maybe
final-ish changes ;)

> > I have not tested my drive to actually return zeros after trimming but
> > from the kernel code I would assume that its intent is to match all
> > Crucial SSDs and thus it is a bug mine is not matched. If someone
> > tells me to the preferred method to test it I am happy to do this. If
> > need be I can also submit a patch (just for MX500? all of the above?).  
> 
> There's no way to exhaustively test. Many drives will return zeroes most
> of the time but can have corner conditions that cause them to ignore
> TRIM commands.

Sure, but since the whitelist was filled with devices that have been
tested/validated empirically, I wonder how thorough this needs to be
to add a drive with good confidence. After all, the vendor wildcard
for Crucial SSDs[1] has been quite broad and only restricted later
with blacklist entries (only due to NCQ trim and LPM problems AFAICT)...
So while queued trim is not blacklisted on my device the safe zeroing
assumption is not whitelisted for no other reason than the model
string missing "Crucial " at the beginning.
 
> > Is there any way to see which flags the kernel applies to a drive?  
> 
> # grep . /sys/class/ata_device/*/trim
> /sys/class/ata_device/dev1.0/trim:unqueued
> /sys/class/ata_device/dev2.0/trim:queued

But that's only to distinguish ATA_HORKAGE_NO_NCQ_TRIM I guess? While
this seems to be the major culprit of trim related issues I don't care
about that (yet).

> > Interestingly, "lsblk -D" does only show "0" for the Samsung device
> > (although AFAICT it is matched by the white list AND reports
> > "Deterministic read ZEROs after TRIM" according to hdparm. But I don't
> > know what lsblk actually looks at...?  
> 
> lsblk looks at /sys/block/*/queue/discard*

Yes, I could have checked strace :)

> You get "0" for the discard granularity on the Samsung?

Not for the granularity - that's fine I presume - but for the zeroing
capability. This is still the case (with Linux 5.10). I would have
expected that to be non-zero for devices with
ATA_HORKAGE_ZERO_AFTER_TRIM.

# lsblk -o PATH,MODEL,DISC-ALN,DISC-GRAN,DISC-MAX,DISC-ZERO -d
PATH     MODEL                           DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
/dev/sda CT500MX500SSD4                         0        4K       2G         0
/dev/sdb CT500MX500SSD4                         0        4K       2G         0
/dev/sdc Samsung_SSD_860_EVO_mSATA_500GB        0      512B       2G         0

Just to make sure lsblk is not lying:
# cat /sys/block/sdc/queue/discard_zeroes_data 
0

I don't understand why that's the case.


1: https://github.com/torvalds/linux/blob/7a8526a5cd51cf5f070310c6c37dd7293334ac49/drivers/ata/libata-core.c#L4030

KR
-- 
Dipl.-Ing. Stefan Tauner
Lecturer and former researcher
Embedded Systems Department

University of Applied Sciences Technikum Wien
Hoechstaedtplatz 6, 1200 Vienna, Austria
E: stefan.tauner@technikum-wien.at
I: embsys.technikum-wien.at
