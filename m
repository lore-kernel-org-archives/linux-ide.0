From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/5] ide: skip "VLB sync" if host uses MMIO
Date: Tue, 22 Apr 2008 20:09:12 +0400
Message-ID: <480E0DA8.20306@ru.mvista.com>
References: <200804122103.51449.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758951AbYDVQKA@vger.kernel.org>
In-Reply-To: <200804122103.51449.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Skip "VLB sync" in ata_{in,out}put_data() if host uses MMIO.

> * Use I/O ops directly in ata_vlb_sync() an drop no longer needed
>   'ide_drive_t *drive' argument.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
