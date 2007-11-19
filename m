From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/21] ide: add CONFIG_IDE_H8300 config option
Date: Mon, 19 Nov 2007 21:59:36 +0300
Message-ID: <4741DD18.6050103@ru.mvista.com>
References: <200711182315.52981.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30229 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750875AbXKSS7X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 13:59:23 -0500
In-Reply-To: <200711182315.52981.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Add a separate config option for ide-8300 host driver instead of depending
> on CONFIG_H8300.

> This change is a preparation for the future changes and also allows ide-h8300
> to be disabled if needed.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
