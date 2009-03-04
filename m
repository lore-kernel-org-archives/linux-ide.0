From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 09/15] ide: add "flagged" taskfile flags to struct ide_taskfile
Date: Wed, 04 Mar 2009 21:32:49 +0300
Message-ID: <49AEC951.8080609@ru.mvista.com>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain> <20090201175012.19144.87417.sendpatchset@localhost.localdomain> <20090206170425.201346e6.sfr@canb.auug.org.au> <200902081238.18970.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.mvista.com ([63.81.120.155]:34220 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753485AbZCDScV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Mar 2009 13:32:21 -0500
In-Reply-To: <200902081238.18970.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>>Subject: [PATCH] ide: add "flagged" taskfile flags to struct ide_taskfile

>>>* Add ->ftf_flags field to struct ide_taskfile
>>>  and convert flags for TASKFILE ioctl to use it.

>>>* Rename "flagged" taskfile flags:
>>>  - IDE_TFLAG_FLAGGED -> IDE_FTFLAG_FLAGGED

>>There were several places where this transformation did not take place as
>>shown by today's linux-next build.

> Thanks, it is now fixed with v2 of the patch, interdiff below:

> ...
> v2:
> * Remember to fully update ide-h8300.c, scc_pata.c and tx493{8,9}ide.c
>   (thanks to Stephen Rothwell for noticing).

> There should be no functional changes caused by this patch.

> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
