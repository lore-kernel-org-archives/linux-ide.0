From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/6] sata_sil: convert sil_port[] to u16 from unsigned
 long
Date: Sun, 05 Mar 2006 02:43:22 -0500
Message-ID: <440A969A.5090503@pobox.com>
References: <1141542232248-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:28363 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751128AbWCEHnZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 02:43:25 -0500
In-Reply-To: <1141542232248-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> unsigned long is way too big for sil_port[] offsets (currently the
> table is 256 bytes on 64bit machines).  Convert sil_port[] to u16.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK.  This just forces the compiler to promote these from u16 to machine 
int (i.e. unsigned long) at addition time.  Table size is a very trivial 
matter.

	Jeff



