From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/03] ide misc leftovers
Date: Fri, 21 Nov 2008 21:41:32 +0100
Message-ID: <200811212141.32809.bzolnier@gmail.com>
References: <1227159683-2487-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:2873 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbYKUVoN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Nov 2008 16:44:13 -0500
Received: by ug-out-1314.google.com with SMTP id 39so238326ugf.37
        for <linux-ide@vger.kernel.org>; Fri, 21 Nov 2008 13:44:11 -0800 (PST)
In-Reply-To: <1227159683-2487-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 20 November 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here is Linus' reworked ide-floppy reduce-stack-usage patch. It has been tested
> here on current pata tree with your latest 3 patches adding the per-device
> request queue locks. Along with that are 2 small cleanups.

Thanks, I applied all patches.
