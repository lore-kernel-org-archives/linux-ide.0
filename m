From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/11] drivers/ide: Move a dereference below a NULL test
Date: Tue, 16 Dec 2008 21:49:29 +0100
Message-ID: <200812162149.30288.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0812161611280.20444@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:45074 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYLPUzS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 15:55:18 -0500
Received: by bwz14 with SMTP id 14so4573790bwz.13
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 12:55:16 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0812161611280.20444@pc-004.diku.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Tuesday 16 December 2008, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> In each case, if the NULL test is necessary, then the dereference should be
> moved below the NULL test.

applied, thanks!
