From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Add Seagate STT20000A to DMA blacklist.
Date: Thu, 24 May 2007 02:33:39 +0200
Message-ID: <200705240233.39209.bzolnier@gmail.com>
References: <20070521145042.GA6957@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:3542 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760839AbXEXBYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 21:24:08 -0400
Received: by ug-out-1314.google.com with SMTP id 70so758457ugb
        for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 18:24:08 -0700 (PDT)
In-Reply-To: <20070521145042.GA6957@redhat.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Monday 21 May 2007, Dave Jones wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=1044
> has been open for _four_ years with a patch available.
> Here's a rediffed version of the same.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

Uh, it seems that this fix got stuck in the kernel "black hole"
bugzilla.  Thanks for finding and resurrecting it.  

I've just applied the bigger DMA blacklist update from
Junio C Hamano and it also covers this device.

Bart
