From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] hpt366: kill set_dma_mode() method wrapper
Date: Sun, 9 Dec 2007 18:11:00 +0100
Message-ID: <200712091811.00626.bzolnier@gmail.com>
References: <200712082050.41067.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:57387 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbXLIS5c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 13:57:32 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1339373rvb
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 10:57:26 -0800 (PST)
In-Reply-To: <200712082050.41067.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 08 December 2007, Sergei Shtylyov wrote:
> There's no reason to keep the set_dma_mode() method wrapper for two different
> chip families, so get rid of it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied, thanks!
