From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/15] slc90e66: fix deadlock on error handling
Date: Tue, 02 Oct 2007 17:03:09 +0400
Message-ID: <4702418D.3050502@ru.mvista.com>
References: <200710012334.39975.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:22376 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751151AbXJBND1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 09:03:27 -0400
In-Reply-To: <200710012334.39975.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Stop abusing ide_lock lock (switch to a private locking).

>   Fixes same issue as fixed by Alan Cox in atiixp host driver with
>   commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.

    ... and in the piix as well. Since I failed to see what could lead to this 
in the kernel.org code, I haven't carried the fix to slc90e66...

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
