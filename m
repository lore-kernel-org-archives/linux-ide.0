From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] ide: make wait_drive_not_busy() static again
Date: Fri, 1 Feb 2008 22:52:28 +0100
Message-ID: <200802012252.29101.bzolnier@gmail.com>
References: <20080128221006.GK8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:18393 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756700AbYBAWhI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 17:37:08 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1351439wra.23
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 14:37:07 -0800 (PST)
In-Reply-To: <20080128221006.GK8767@does.not.exist>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 28 January 2008, Adrian Bunk wrote:
> After commit 7267c3377443322588cddaf457cf106839a60463 
> wait_drive_not_busy() can become static again.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied
