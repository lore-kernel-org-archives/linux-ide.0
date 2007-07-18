From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] sc1200: remove redundant warning message from sc1200_tune_chipset()
Date: Wed, 18 Jul 2007 23:06:59 +0200
Message-ID: <200707182306.59533.bzolnier@gmail.com>
References: <200707132310.50310.bzolnier@gmail.com> <4698FBED.7060008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:48988 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385AbXGRVHO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 17:07:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so325092ugf
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 14:07:13 -0700 (PDT)
In-Reply-To: <4698FBED.7060008@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 14 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > ide_config_drive_speed() called by sc1200_set_xfer_mode() already gives
> > a meaningful warning message in case of failure.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
