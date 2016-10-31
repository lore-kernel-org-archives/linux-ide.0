From: Tejun Heo <tj@kernel.org>
Subject: Re: Possible Bug In ATA/SCSI Fixed Sense
Date: Mon, 31 Oct 2016 09:58:40 -0600
Message-ID: <20161031155840.GA24605@mtj.duckdns.org>
References: <CANSCoS8aVbdcb7ZCxcW57FrqKr_k+OuHt0ZFzPLNQRQMZj_Gww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33358 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbcJaP6n (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2016 11:58:43 -0400
Received: by mail-pf0-f177.google.com with SMTP id d2so3663304pfd.0
        for <linux-ide@vger.kernel.org>; Mon, 31 Oct 2016 08:58:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANSCoS8aVbdcb7ZCxcW57FrqKr_k+OuHt0ZFzPLNQRQMZj_Gww@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Charles Machalow <csm10495@gmail.com>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Hello,

On Fri, Oct 28, 2016 at 11:34:22AM -0700, Charles Machalow wrote:
> As of Linux commit 14970f204b1993af7459d5bd34aaff38dfee6670, In
> drivers/ata/libata-scsi.c in ata_gen_passthru_sense() line 1087,
> desc[0] is set to tf->feature. This makes sense to me however 4 lines
> below the same item in the array is set to 0.
> 
> One of these lines must be unintended as no matter what the field will
> always be 0 though for a couple lines it is set to tf-feature.
> 
> I think that line 1091 is at fault because if I send down a nop
> command, feature (error in this case) should be set to 4 in the
> returned current task file.

This looks to be from 11093cb1ef56 ("libata-scsi: generate correct ATA
pass-through sense").  Hannes?

Thanks.

-- 
tejun
