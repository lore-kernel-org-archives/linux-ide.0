From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/15] ali14xx: fix deadlock on error handling
Date: Tue, 02 Oct 2007 16:46:28 +0400
Message-ID: <47023DA4.1020607@ru.mvista.com>
References: <200710012331.26965.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:22279 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751213AbXJBMqr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 08:46:47 -0400
In-Reply-To: <200710012331.26965.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Stop abusing ide_lock lock by switching to a private locking.

> Fixes same issue as fixed by Alan Cox in atiixp host driver with

    Has been also fixed in the piix driver.

> commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.

    Heh, I've looked hard at the code trying to understand how this can 
happen, and was unable to figure out. Probably was not hard enough...

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
