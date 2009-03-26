From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide: Fix code dealing with sleeping devices in do_ide_request()
Date: Thu, 26 Mar 2009 21:18:18 +0100
Message-ID: <200903262118.19109.bzolnier@gmail.com>
References: <8763hxs87w.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:60835 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZCZVTT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 17:19:19 -0400
Received: by fxm2 with SMTP id 2so765066fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2009 14:19:17 -0700 (PDT)
In-Reply-To: <8763hxs87w.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org

On Wednesday 25 March 2009, Elias Oltmanns wrote:
> Unfortunately, I missed a catch when reviewing the patch committed as
> 201bffa4. Here is the fix to the currently broken handling of sleeping
> devices. In particular, this is required to get the disk shock
> protection code working again.
> 
> Reported-by: Christian Thaeter <ct@pipapo.org>
> Cc: stable@kernel.org
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

applied, thanks for fixing it!
