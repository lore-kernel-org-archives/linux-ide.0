From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] libata: glob_match for ata_device_blacklist
Date: Thu, 01 Jul 2010 15:24:32 -0400
Message-ID: <4C2CEB70.3090209@pobox.com>
References: <4C2CB497.3000701@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37658 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab0GATYy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 15:24:54 -0400
Received: by gye5 with SMTP id 5so40511gye.19
        for <linux-ide@vger.kernel.org>; Thu, 01 Jul 2010 12:24:46 -0700 (PDT)
In-Reply-To: <4C2CB497.3000701@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 07/01/2010 11:30 AM, Mark Lord wrote:
>
> Replace rudimentry pattern matching with more capable shell-style globbing.
> This will enable shrinking ata_device_blacklist[] table in subsequent
> patches,
> and helps with future editions to the table, such as matching only the end
> of a firmware revision string etc..
>
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
>
> Eventually, this function should move out of libata into lib/string.c or
> similar (?).
> But since following patches in this series require it for libata,
> let's start with it there, and move things later on.

hmmm, can you resend this series as an attachment?  The patch is failing 
miserably here, both with 'git am' and patch(1).  I don't see anything 
obviously wrong with the patch other than line numbers -- did you diff 
against the latest upstream kernel (torvalds/linux-2.6.git)?

Adding "-l" to patch(1) causes hunk #2 of patch #1 to succeed, but being 
the smaller hunk, that's the less useful of the two.

	Jeff




[jgarzik@bd libata-dev]$ patch -l --verbose drivers/ata/libata-core.c < 
.git/rebase-apply/patch
Hmm...  Looks like a unified diff to me...
The text leading up to this was:
--------------------------
|---
|
|Eventually, this function should move out of libata into lib/string.c 
or similar (?).
|But since following patches in this series require it for libata,
|let's start with it there, and move things later on.
|
|--- 2.6.34/drivers/ata/libata-core.c	2010-05-16 17:17:36.000000000 -0400
|+++ linux/drivers/ata/libata-core.c	2010-07-01 11:08:10.509159666 -0400
--------------------------
Patching file drivers/ata/libata-core.c using Plan A...
Hunk #1 FAILED at 4413.
Hunk #2 succeeded at 4359 (offset -87 lines).
1 out of 2 hunks FAILED -- saving rejects to file 
drivers/ata/libata-core.c.rej
Hmm...  Ignoring the trailing garbage.
done

