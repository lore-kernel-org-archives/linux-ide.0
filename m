From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 02/63] ide-cd: fix ACER/AOpen 24X CDROM speed reporting
 on big-endian machines
Date: Fri, 21 Dec 2007 14:44:55 +0300
Message-ID: <476BA737.3060305@ru.mvista.com>
References: <200712200151.39973.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30115 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751585AbXLULoe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Dec 2007 06:44:34 -0500
In-Reply-To: <200712200151.39973.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Fix ACER/AOpen 24X CDROM speed reporting on big-endian machines
>   by adding missing le16_to_cpu() calls.

> While at it:
> * Replace ntohs() by be16_to_cpu().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
