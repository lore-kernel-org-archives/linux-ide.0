From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] isd200: use ATA_* defines instead of *_STAT and *_ERR ones
Date: Thu, 24 Jul 2008 22:16:59 +0200
Message-ID: <200807242216.59516.bzolnier@gmail.com>
References: <200807242123.42923.bzolnier@gmail.com> <20080724195722.GA9859@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:58854 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbYGXUT2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 16:19:28 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2220816mue.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2008 13:19:26 -0700 (PDT)
In-Reply-To: <20080724195722.GA9859@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 24 July 2008, Greg KH wrote:
> On Thu, Jul 24, 2008 at 09:23:42PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Thanks, please also take a look at previous isd200 patches
when you have some time:

http://lkml.org/lkml/2008/7/23/213
http://lkml.org/lkml/2008/7/23/197

[ they should also be in your overflowed inbox :) ]
