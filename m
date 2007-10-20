From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 11/12] ide: add ide_no_data_taskfile() helper
Date: Sat, 20 Oct 2007 23:21:06 +0400
Message-ID: <471A5522.5090401@ru.mvista.com>
References: <200710082318.37597.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:62127 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750804AbXJTTUz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Oct 2007 15:20:55 -0400
In-Reply-To: <200710082318.37597.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add ide_no_data_taskfile() helper and convert ide_raw_taskfile() w/ NO DATA
>   protocol users to use it instead.

> * Set ->data_phase explicitly in ide_no_data_taskfile()
>   (TASKFILE_NO_DATA is defined as 0x0000).

> * Unexport task_no_data_intr().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

