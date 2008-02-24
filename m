From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/10] IDE: Coding Style Fixes
Date: Sun, 24 Feb 2008 16:49:51 +0100
Message-ID: <200802241649.51627.bzolnier@gmail.com>
References: <20080223150436.6c09ce54@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:31376 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbYBXQcC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 11:32:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so457572ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 08:32:00 -0800 (PST)
In-Reply-To: <20080223150436.6c09ce54@paolo-desktop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Adrian Bunk <bunk@kernel.org>, Cyrill Gorcunov <gorcunov@gmail.com>


On Saturday 23 February 2008, Paolo Ciarrocchi wrote:
> Hi Bartlomiej,
> The following 10 patches remove a huge number of errors and warnings
> reported by checkpatch.pl from the IDE subsystem.

[...]

Thanks!

I applied everything (patch #8 with fixes based on comments from
Adrian & Cyrill + patches #1/2/4/5 also with some improvements)
and verified that md5sums for the resulting binary files remain
the same.

Bart
