From: Tejun Heo <htejun@gmail.com>
Subject: CDC_PLAY_AUDIO check in cdrom_count_tracks() and other oddities
Date: Thu, 12 Jun 2008 12:51:28 +0900
Message-ID: <48509D40.2060901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:23189 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbYFLDvd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 23:51:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1807979rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 20:51:33 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Hello, Jens.

I'm tracking down a bug where HAL doesn't mount media automatically.
It turned out that CDROM_DISC_STATUS wasn't reporting correct disc
type which was caused by CDC_PLAY_AUDIO check failure at the top of
cdrom_count_tracks().

I've went through MMC-3 but couldn't find anything which associates
play audio capability with READ_TOC.  READ_TOC was mandatory command,
so according to MMC-3, there's no reason to avoid issuing READ_TOC on
!CDC_PLAY_AUDIO.  Is there something I don't know?

Thanks.

-- 
tejun
