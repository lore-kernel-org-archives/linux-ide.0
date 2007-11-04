From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/9] ide-disk: fix __ide_do_rw_disk() to use ->OUTBSYNC
Date: Sun, 04 Nov 2007 15:57:26 +0300
Message-ID: <472DC1B6.7000208@ru.mvista.com>
References: <200711022259.13661.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:10640 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751564AbXKDM5b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Nov 2007 07:57:31 -0500
In-Reply-To: <200711022259.13661.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Fix __ide_do_rw_disk() to use ->OUTBSYNC instead of ->OUTB
> (needed for pmac and scc_pata host drivers).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
