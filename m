From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] silence warning in drivers/ata/libata-scsi.c when
 building W=1
Date: Mon, 1 Aug 2016 11:04:29 -0400
Message-ID: <20160801150429.GD2542@mtj.duckdns.org>
References: <8997.1470022114@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33301 "EHLO
	mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbcHAPEc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Aug 2016 11:04:32 -0400
Content-Disposition: inline
In-Reply-To: <8997.1470022114@turing-police.cc.vt.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jul 31, 2016 at 11:28:34PM -0400, Valdis Kletnieks wrote:
> When building with W=1, we get these warnings:
> 
> drivers/ata/libata-scsi.c: In function 'ata_mselect_caching':
> drivers/ata/libata-scsi.c:3637:28: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
>     if (mpage[i + 2] & 0xfb != buf[i] & 0xfb) {
>                        ~~~~~^~~~~~~~~
> drivers/ata/libata-scsi.c: In function 'ata_mselect_control':
> drivers/ata/libata-scsi.c:3702:28: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
>     if (mpage[i + 2] & 0xfb != buf[i] & 0xfb) {
>                        ~~~~~^~~~~~~~~
> 
> So give them the extra () and make things a bit clearer for both the
> compiler and programmer...
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

The offending commit got already reverted.

Thanks!

-- 
tejun
