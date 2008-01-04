From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 07/10] ide-floppy: remove unnecessary ->handler != NULL check
Date: Fri, 4 Jan 2008 02:24:12 +0100
Message-ID: <200801040224.12563.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-7-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-8-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:60776 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbYADBTg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 20:19:36 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2729247ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 03 Jan 2008 17:19:36 -0800 (PST)
In-Reply-To: <1199366409-26016-8-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Thursday 03 January 2008, Borislav Petkov wrote:
> This BUG_ON is unneeded since the ->handler != NULL check is performed in
> ide_set_handler().
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

looks good, please move it at the beginning of the patch series
