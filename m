From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/5] ide: remove PIO "downgrade" quirk
Date: Mon, 18 Feb 2008 19:06:53 +0300
Message-ID: <47B9AD1D.4020307@ru.mvista.com>
References: <20080217185105.16210.26582.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758930AbYBRQGG@vger.kernel.org>
In-Reply-To: <20080217185105.16210.26582.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> No need for it nowadays

    Since which moment, could you elaborate

> so remove quirk code from ide_get_best_pio_mode()
> and IDE_HFLAG_PIO_DOWNGRADE host flag.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

MBR, Sergei
