From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [2.6 patch] drivers/ide/: cleanups
Date: Tue, 11 Jul 2006 18:38:32 +0400
Message-ID: <44B3B7E8.3080800@ru.mvista.com>
References: <20060711141637.GS13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750902AbWGKOjp@vger.kernel.org>
In-Reply-To: <20060711141637.GS13938@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

Adrian Bunk wrote:

> This patch contains the following clenups:
> - setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
> - ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)

    It's used by arm/bast-ide.c (CONFIG_NLK_DEV_IDE_BAST is defined as 
tristate). I don't understand what's the point insisting on its removal since 
any SOC modular driver in the future may need it...

> - ide-dma.c: remove the unused EXPORT_SYMBOL_GPL(ide_in_drive_list)

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

WBR, Sergei
