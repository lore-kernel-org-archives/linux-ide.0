From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/9] ide-disk: add ide_do_setfeature() helper
Date: Wed, 20 Aug 2008 14:04:19 +0400
Message-ID: <48ABEC23.6070401@ru.mvista.com>
References: <20080817171454.27943.37234.sendpatchset@localhost.localdomain> <20080817171514.27943.66688.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755592AbYHTKEi@vger.kernel.org>
In-Reply-To: <20080817171514.27943.66688.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Add ide_do_setfeature() helper and convert set_{wcache,acoustic}()
> to use it.
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
