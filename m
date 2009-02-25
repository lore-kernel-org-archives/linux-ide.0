From: Mark Lord <liml@rtr.ca>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Wed, 25 Feb 2009 17:43:49 -0500
Message-ID: <49A5C9A5.20005@rtr.ca>
References: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600> <26917692A9574F3A9363ED5253B42D2F@DIAMOND8600> <49A570DB.8090401@rtr.ca> <200902252035.05347.bzolnier@gmail.com> <DF79A3D50A1548A2A22EEFD769318266@DIAMOND8600>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:36956 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755636AbZBYWnw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 17:43:52 -0500
In-Reply-To: <DF79A3D50A1548A2A22EEFD769318266@DIAMOND8600>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norman Diamond <n0diamond@yahoo.co.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Norman Diamond wrote:
>
> Meanwhile I also can't help wondering, if Mark Lord has patched drivers/ide
> to make it work, why has he delayed submitting the patches?
..

There's simply too much churn in drivers/ide for me to keep up with,
and my patches won't apply to kernels from the past year.

Drivers/ide is on the way out FAST now, and any new systems that
still use it are mostly based on older kernels, where patches like
mine are inappropriate for maintenance point releases.

Libata should be used for any new setup that doesn't have a strict
legacy requirement now.

Cheers
