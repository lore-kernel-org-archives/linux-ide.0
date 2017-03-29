From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] pata_atiixp: Fix IDE detection on SB7xx
Date: Wed, 29 Mar 2017 13:34:15 +0300
Message-ID: <e3812d46-bfc4-57a1-882d-751e03968433@cogentembedded.com>
References: <49ce56dc322.70129c23@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34886 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755527AbdC2KeS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Mar 2017 06:34:18 -0400
Received: by mail-lf0-f54.google.com with SMTP id j90so5418249lfk.2
        for <linux-ide@vger.kernel.org>; Wed, 29 Mar 2017 03:34:17 -0700 (PDT)
In-Reply-To: <49ce56dc322.70129c23@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>, tj@kernel.org
Cc: tourula@gmail.com, linux-ide@vger.kernel.org

Hello!

On 3/28/2017 6:57 PM, Darren Stevens wrote:

> Commit: 5946fdaee4ba(pata_atiixp: Don't use unconnected secondary port on

    Need space before the 1st paren, and summary enclosed in (""), not just ().

> SB600/SB700) disabled the check for secondary ports on AMD SB700/710/750
>
> While these chips have only 1 IDE port, it can be reconfigured on SB7xx
> to appear as a secondary channel, especially when 'Legacy IDE emulation'
> is enabled, breaking IDE detection on some boards with this chipset.
>
> Fix by removing the check for SB7xx.
>
> Fixes: 5946fdaee4ba(pata_atiixp: Don't use unconnected secondary port
> on SB600/SB700)

    Required the same standardized format as described above.

> Signed-off-by: Darren Stevens <Darren@stevens-zone.net>
[...]

MBR, Sergei

