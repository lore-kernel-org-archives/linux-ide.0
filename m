From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/9] ide: remove 'handler' field from ide_task_t
Date: Thu, 29 Nov 2007 20:37:39 +0300
Message-ID: <474EF8E3.5030605@ru.mvista.com>
References: <200711022305.33889.bzolnier@gmail.com> <200711030400.11562.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:3938 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756090AbXK2Rh0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 12:37:26 -0500
In-Reply-To: <200711030400.11562.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>* Add IDE_TFLAG_CUSTOM_HANDLER taskfile flag and use it for internal requests
>>  which require custom handlers.  Check the flag in do_rw_taskfile() and set
>>  handler accordingly.

>>* Cleanup ide_init_{specify,restore,setmult}_cmd() and rename it to
>>  ide_tf_set_{specify,restore,setmult}_cmd().

>>* Make {set_geometry,recal,set_multmode}_intr() static.

>>* Remove no longer needed 'handler' field from ide_task_t.

>>There should be no functionality changes caused by this patch.


> except that it doesn't work 8) working version below

> [PATCH] ide: remove 'handler' field from ide_task_t (take 2)

> * Add IDE_TFLAG_CUSTOM_HANDLER taskfile flag and use it for internal requests
>   which require custom handlers.  Check the flag in do_rw_taskfile() and set
>   handler accordingly.

> * Cleanup ide_init_{specify,restore,setmult}_cmd() and rename it to
>   ide_tf_set_{specify,restore,setmult}_cmd().

> * Make {set_geometry,recal,set_multmode}_intr() static.

> * Remove no longer needed 'handler' field from ide_task_t.

> v2:
> * 'handler' in do_rw_taskfile() must be set to NULL initially.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
