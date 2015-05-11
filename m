From: Matthew Garrett <matthew.garrett@coreos.com>
Subject: Re: [PATCH 2/3] libata: Add firmware_default LPM policy
Date: Mon, 11 May 2015 13:24:18 -0700
Message-ID: <CAPeXnHuSccpYkDRmWO5tKuec2q0WqX7Ktxk_yX9te77xrEe=SA@mail.gmail.com>
References: <1429370796-5881-1-git-send-email-mjg59@coreos.com>
	<1429370796-5881-3-git-send-email-mjg59@coreos.com>
	<20150422144812.GA10592@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33701 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbbEKUYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2015 16:24:19 -0400
Received: by oica37 with SMTP id a37so114126447oic.0
        for <linux-ide@vger.kernel.org>; Mon, 11 May 2015 13:24:18 -0700 (PDT)
In-Reply-To: <20150422144812.GA10592@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Matthew Garrett <mjg59@coreos.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, kristen@linux.intel.com, sgunderson@bigfoot.com

Ok, I've had one person testing this report the following:

[ 1896.902726] ata1.00: exception Emask 0x0 SAct 0x800 SErr 0x40000 action 0x0
[ 1896.902735] ata1.00: irq_stat 0x40000008
[ 1896.902741] ata1: SError: { CommWake }
[ 1896.902748] ata1.00: failed command: WRITE FPDMA QUEUED
[ 1896.902758] ata1.00: cmd 61/18:58:88:d5:5d/00:00:0d:00:00/40 tag 11
ncq 12288 out
         res 41/04:00:9f:d5:5d/00:00:0d:00:00/40 Emask 0x401 (device error) <F>
[ 1896.902764] ata1.00: status: { DRDY ERR }
[ 1896.902768] ata1.00: error: { ABRT }
[ 1896.912725] ata1.00: supports DRM functions and may not be fully accessible
[ 1896.932716] ata1.00: supports DRM functions and may not be fully accessible
[ 1896.942783] ata1.00: configured for UDMA/133
[ 1896.942815] ata1: EH complete

which seems to occur in batches. I'm a little confused - isn't it
legitimate for the phy to report comwake here?
-- 
Matthew Garrett | matthew.garrett@coreos.com
