From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] tx4939ide: remove wmb()
Date: Thu, 2 Apr 2009 21:11:15 +0200
Message-ID: <200904022111.15347.bzolnier@gmail.com>
References: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58010 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758890AbZDBTgh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 15:36:37 -0400
In-Reply-To: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Grant Grundler <grundler@google.com>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org

On Tuesday 31 March 2009, Atsushi Nemoto wrote:
> * define CHECK_DMA_MASK
> * remove use of wmb()
> 
> Suggested-by: Grant Grundler <grundler@google.com>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

applied
