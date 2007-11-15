From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pata_sis.c: Add Packard Bell EasyNote K5305 to laptops
Date: Thu, 15 Nov 2007 12:06:55 +0900
Message-ID: <473BB7CF.7020801@gmail.com>
References: <473A0B57.4030703@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:63140 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756709AbXKODJy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 22:09:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so472473wah
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 19:09:54 -0800 (PST)
In-Reply-To: <473A0B57.4030703@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabriel C <nix.or.die@googlemail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

Gabriel C wrote:
> Hi,
> 
> With newer kernels HDD in my old laptop is limited to UDMA 33.
> With this patch I get UDMA 100 again.
> 
> Signed-off-by: Gabriel Craciunescu <nix.or.die@googlemail.com>

applied to #tj-upstream-fixes with Hi, edited out.  :-)

-- 
tejun

