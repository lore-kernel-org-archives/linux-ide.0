From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 20/63] ide-cd: remove needless zeroing of 'info' fields
 from ide_cdrom_setup()
Date: Fri, 21 Dec 2007 15:41:57 +0300
Message-ID: <476BB495.5050809@ru.mvista.com>
References: <200712200208.20568.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758273AbXLUMlr@vger.kernel.org>
In-Reply-To: <200712200208.20568.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> ide_cd_probe() zeroes 'info' prior to calling ide_cdrom_setup() so there
> is no need to explicitly zero 'info' fields in the latter function.

> Ditto for fields of CDROM_STATE_FLAGS(), CDROM_CONFIG_FLAGS() and 'cdi'
> (all are embedded in 'info').

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
