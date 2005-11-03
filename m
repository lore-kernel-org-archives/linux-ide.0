From: Martin Murray <mmurray@deepthought.org>
Subject: Re: [UPDATED][PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Thu, 3 Nov 2005 16:43:55 -0500
Message-ID: <20051103214355.GA3516@deepthought.org>
References: <CA45571DE57E1C45BF3552118BA92C9D69BF2F@WDSCEXBECL03.sc.wdc.com> <20051102084917.GM26049@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from carbon.deepthought.org ([66.180.175.50]:53407 "EHLO
	carbon.deepthought.org") by vger.kernel.org with ESMTP
	id S1030504AbVKCVoB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Nov 2005 16:44:01 -0500
Content-Disposition: inline
In-Reply-To: <20051102084917.GM26049@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Just a few quick questions:

regarding HDIO_DRIVE_TASKFILE:
    I don't see any exact information, however, from what I can infer
from the code, it appears that while the user can specify an
input buffer and/or an output buffer, only one of the buffers would be
filled with useful information. Is it reasonable to assume that
req_task->out_size == 0 req_task->in_size == 0? Or, more specifically,
is it reasonable to return -EINVAL if both are non zero?

    If I were to do zero_copy IO using blk_rq_map_user, should I verify
the user buffer is valid with access_ok() ?

    Why does ide_diag_taskfile() allocate a custom request structure
instead of using blk_get_request(drive->queue, ...) ?

    Given HDIO_DRIVE_TASKFILE, what is the purpose of HDIO_DRIVE_TASK
and HDIO_DRIVE_CMD?

Thank you, Martin
