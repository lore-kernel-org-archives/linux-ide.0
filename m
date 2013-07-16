From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: move 'struct ata_taskfile' and friends from
 ata.h to libata.h
Date: Tue, 16 Jul 2013 05:47:29 -0600
Message-ID: <20130716114729.GA23827@mtj.dyndns.org>
References: <201307010001.32816.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35096 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932306Ab3GPLri (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jul 2013 07:47:38 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so694879pad.2
        for <linux-ide@vger.kernel.org>; Tue, 16 Jul 2013 04:47:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201307010001.32816.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org

On Mon, Jul 01, 2013 at 12:01:32AM +0400, Sergei Shtylyov wrote:
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> Move 'struct ata_taskfile', ata_prot_flags() and their friends from
> <linux/ata.h> to <linux/libata.h>. They were misplaced from the beginning,  as
> <linux/ata.h> should cover ATA/ATAPI and related standards only -- to which the
> aforementioned structure and function have only remote relation. 
> 
> I would have moved 'enum ata_tf_protocols' closely related to 'struct
> ata_taskfile' but it unfortunately gets used by 'drivers/ide/ide-ioctls.c'...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Applied to libata/for-3.12.  Thanks!

-- 
tejun
