From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] libata fixes for v3.14-rc5
Date: Sat, 8 Mar 2014 11:57:18 -0800
Message-ID: <CA+55aFzgg4hicXQ-cwHZdDrGRPSoeUVeMzPRAmoEYrujLjt1_A@mail.gmail.com>
References: <20140308152854.GB25021@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:45966 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaCHT5T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Mar 2014 14:57:19 -0500
In-Reply-To: <20140308152854.GB25021@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>

On Sat, Mar 8, 2014 at 7:28 AM, Tejun Heo <tj@kernel.org> wrote:
>
> Just a couple patches blacklisting more broken devices.

Pulled. However:

>         /* devices that don't properly handle queued TRIM commands */
>         { "Micron_M500*",               NULL,   ATA_HORKAGE_NO_NCQ_TRIM, },
>         { "Crucial_CT???M500SSD1",      NULL,   ATA_HORKAGE_NO_NCQ_TRIM, },
> +       { "Crucial_CT???M500SSD3",      NULL,   ATA_HORKAGE_NO_NCQ_TRIM, },

If we know M500SSD1 and M500SSD3 are both broken the same way, and the
Micron_M500* is too (which is, as far as I know, the same device), why
the heck do we make the test that specific?

Why not just use Crucial_CT???M500* or something? The likelihood of
some new version of the same broken device coming up is small, and if
it does, we don't even care. Why would we risk it?

            Linus
