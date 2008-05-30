From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 05/21] ide: remove XFER_* masks from ide-timing.h
Date: Fri, 30 May 2008 15:46:04 +0400
Message-ID: <483FE8FC.4070902@ru.mvista.com>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain> <20080528214027.16327.95083.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752370AbYE3Lqg@vger.kernel.org>
In-Reply-To: <20080528214027.16327.95083.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Check requested xfer mode against xfer modes instead of XFER_* masks
>   in ide_timing_compute() and cs5535.c::cs5535_set_speed().

> * Remove XFER_[MODE,MWDMA,EPIO,PIO] masks.

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
