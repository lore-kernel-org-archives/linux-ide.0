From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/7] ide: replace special_t typedef by IDE_SFLAG_* flags
Date: Thu, 14 May 2009 17:04:09 +0400
Message-ID: <4A0C16C9.10508@ru.mvista.com>
References: <20090513205139.28638.87226.sendpatchset@localhost.localdomain> <20090513205207.28638.44663.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4742 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757790AbZENNDa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 May 2009 09:03:30 -0400
In-Reply-To: <20090513205207.28638.44663.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Replace:
> - special_t typedef by IDE_SFLAG_* flags
> - 'special_t special' ide_drive_t's field by 'u8 special_flags' one

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

WBR, Sergei
