From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-iops: only clear DMA words on setting DMA mode
Date: Wed, 11 Mar 2009 17:35:26 +0100
Message-ID: <200903111735.26956.bzolnier@gmail.com>
References: <200903102238.15619.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:36933 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbZCKRAw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 13:00:52 -0400
Received: by ewy25 with SMTP id 25so80032ewy.37
        for <linux-ide@vger.kernel.org>; Wed, 11 Mar 2009 10:00:49 -0700 (PDT)
In-Reply-To: <200903102238.15619.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 10 March 2009, Sergei Shtylyov wrote:
> The bytes indicating current DMA mode in the identify data words 62, 63, and 88
> should only change on setting a DMA mode, so stop clearing them  on setting PIO
> mode in ide_config_drive_speed().  While at it, correct SW/MW DMA mode masks...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
