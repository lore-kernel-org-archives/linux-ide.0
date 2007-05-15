From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/5] Use mutex instead of semaphore in IDE driver
Date: Wed, 16 May 2007 00:04:48 +0200
Message-ID: <200705160004.48294.bzolnier@gmail.com>
References: <20070514090256.GF29206@traven> <20070514091424.GH29206@traven>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:36336 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760518AbXEPAqb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 20:46:31 -0400
Received: by ug-out-1314.google.com with SMTP id 44so2831uga
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 17:46:31 -0700 (PDT)
In-Reply-To: <20070514091424.GH29206@traven>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On Monday 14 May 2007, Matthias Kaehlcke wrote:
> The IDE driver uses a semaphore as mutex. Use the mutex API instead of
> the (binary) semaphore.
> 
> Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>

applied

Since I already had a patch from you with identical patch summary/description
(but for ide_cfg_sem semaphore) in my tree, I almost overlooked this one. :)

Please choose more descriptive patch summary/description next time.

Thanks,
Bart
