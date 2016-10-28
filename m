From: Charles Machalow <csm10495@gmail.com>
Subject: Possible Bug In ATA/SCSI Fixed Sense
Date: Fri, 28 Oct 2016 11:34:22 -0700
Message-ID: <CANSCoS8aVbdcb7ZCxcW57FrqKr_k+OuHt0ZFzPLNQRQMZj_Gww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35448 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941632AbcJ1Sen (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Oct 2016 14:34:43 -0400
Received: by mail-qk0-f175.google.com with SMTP id z190so96639928qkc.2
        for <linux-ide@vger.kernel.org>; Fri, 28 Oct 2016 11:34:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hi all,

As of Linux commit 14970f204b1993af7459d5bd34aaff38dfee6670, In
drivers/ata/libata-scsi.c in ata_gen_passthru_sense() line 1087,
desc[0] is set to tf->feature. This makes sense to me however 4 lines
below the same item in the array is set to 0.

One of these lines must be unintended as no matter what the field will
always be 0 though for a couple lines it is set to tf-feature.

I think that line 1091 is at fault because if I send down a nop
command, feature (error in this case) should be set to 4 in the
returned current task file.

Thanks!

- Charlie Scott Machalow
