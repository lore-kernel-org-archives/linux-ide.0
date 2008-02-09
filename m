From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] ide-tape: remove never executed code
Date: Sat, 09 Feb 2008 20:54:39 +0300
Message-ID: <47ADE8DF.4090202@ru.mvista.com>
References: <200802091623.46896.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755903AbYBIRyE@vger.kernel.org>
In-Reply-To: <200802091623.46896.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> rq->cmd[0] is never set to REQ_IDETAPE_READ_BUFFER so remove
> REQ_IDETAPE_READ_BUFFER handling from idetape_create_write_cmd()
> and the define itself.

> Then remove no longer used idetape_create_read_buffer_cmd()
> and IDETAPE_RETRIEVE_FAULTY_BLOCK define.

> There should be no functional changes caused by this patch.

> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
