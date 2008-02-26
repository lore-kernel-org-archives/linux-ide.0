From: Tejun Heo <htejun@gmail.com>
Subject: Re: ops->qc_defer not invoked on ata_exec_internal_sg() paths ?
Date: Tue, 26 Feb 2008 10:37:31 +0900
Message-ID: <47C36D5B.7080600@gmail.com>
References: <47C35B6B.8000406@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:9088 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbYBZBhk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2008 20:37:40 -0500
Received: by gv-out-0910.google.com with SMTP id s4so781398gve.37
        for <linux-ide@vger.kernel.org>; Mon, 25 Feb 2008 17:37:38 -0800 (PST)
In-Reply-To: <47C35B6B.8000406@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mark.

Mark Lord wrote:
> The optional .qc_defer() methods don't seem to be called
> on the ata_exec_internal_sg() path.
> 
> At present, this is probably okay.  But in the future,
> as we add functionality for link power management
> and hotplug polling, this could be a problem.
> 
> I think.  Or is it possibly also a problem today
> for sata_send_pmp() and friends ?

That's intentional and okay.  Currently, EH can only issue one non-NCQ
command at a time and dynamic link PM and hotplug polling shouldn't be
done via EH anyway.  EH is way too big a hammer for those.

Thanks.

-- 
tejun
