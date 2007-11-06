From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/18] ide: don't BUG() on unsupported transfer modes
Date: Tue, 06 Nov 2007 14:42:19 +0300
Message-ID: <4730531B.40402@ru.mvista.com>
References: <200711050029.20029.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:30636 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753848AbXKFLmF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 06:42:05 -0500
In-Reply-To: <200711050029.20029.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Fix ide-cris, cs5530, sc1200 and sis5513 host drivers to just return instead
> of OOPS-ing for unsupported modes in ->set_dma_mode methods.

    Wait... weren't you going to make all the other drivers oops in this case?

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
