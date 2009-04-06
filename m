From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] tx4939ide: Fix tx4939ide_{in,out}put_data_swap argument
Date: Mon, 6 Apr 2009 22:58:25 +0200
Message-ID: <200904062258.26062.bzolnier@gmail.com>
References: <1239035801-9603-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:42401 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbZDFVLi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Apr 2009 17:11:38 -0400
In-Reply-To: <1239035801-9603-1-git-send-email-anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 06 April 2009, Atsushi Nemoto wrote:
> The commit adb1af9 ("ide: pass command instead of request to
> ide_pio_datablock()") missed tx4939ide driver.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

applied, thanks
