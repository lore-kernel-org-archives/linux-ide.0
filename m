From: Tejun Heo <tj@kernel.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 08:46:43 +0900
Message-ID: <4B145963.6080406@kernel.org>
References: <1259561052.2076.73.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41577 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841AbZK3Xq1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Nov 2009 18:46:27 -0500
In-Reply-To: <1259561052.2076.73.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

Hello,

On 11/30/2009 03:04 PM, Benjamin Herrenschmidt wrote:
> Now, for libata, I haven't totally figured out what to do though.
> 
> It seems like when the state "changes", I can do something like ahci and
> call ata_ehi_hotplugged() followed by something like ata_port_freeze()
> to kick the EH... at least that's my rough understanding.

Yeap, that should be enough.

> But I don't quite get how to inform libata that the part has or has not
> something plugged in it. I thought about playing with the probe_mask but
> it looks like ata_eh_link_autopsy() will reset that since I'm PATA, not
> SATA and thus have no sata_scr_read()...

No, it won't reset the mask.  It will only reset if SCR read failed
with errors other than -EOPNOTSUPP.  If your driver isn't implementing
SCR access, it will fail with -EOPNOTSUPP.  Also, if SCR access fails,
autopsy dosen't clear probe_mask, it sets all bits there forcing
recovery part to full probing.

Anyways, setting probe_mask (if you don't know which is gone, setting
all bits works fine) and calling ata_port_freeze() is enough.  The
actual hot plug/unlpug path is the same as boot probing path, so
there's nothing more to do there.

Thanks.

-- 
tejun
