From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-scsi: Fixup ata_gen_passthru_sense()
Date: Tue, 1 Nov 2016 11:33:47 -0600
Message-ID: <20161101173347.GB16704@mtj.duckdns.org>
References: <1477944418-110380-1-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34439 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbcKARdu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2016 13:33:50 -0400
Received: by mail-pf0-f196.google.com with SMTP id y68so6318177pfb.1
        for <linux-ide@vger.kernel.org>; Tue, 01 Nov 2016 10:33:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1477944418-110380-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Charles Machalow <csm10495@gmail.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>

On Mon, Oct 31, 2016 at 09:06:58PM +0100, Hannes Reinecke wrote:
> There's a typo in ata_gen_passthru_sense(), where the first byte
> would be overwritten incorrectly later on.
> 
> Reported-by: Charles Machalow <csm10495@gmail.com>
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Applied to libata/for-4.9-fixes with stable cc'd.

Thanks.

-- 
tejun
