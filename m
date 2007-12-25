From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/63] ide-cd: redux
Date: Tue, 25 Dec 2007 14:05:14 -0800
Message-ID: <20071225140514.fa13f5ac.akpm@linux-foundation.org>
References: <200712200148.49690.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38937 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752182AbXLYWFy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Dec 2007 17:05:54 -0500
In-Reply-To: <200712200148.49690.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 20 Dec 2007 01:48:49 +0100 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> This patch series is a major rework of the ide-cd driver.

woo-hoo.

> PS ide-cd Maintainer position is still open...

boo-hoo.

I wish someone would fix that "The drive appears confused (ireason =
0x%02x)" thing.  I had a go a while back but iirc the reporter disappeared
on me.  It is somewhat common.

Or do you think this patch might indeed fix it?
