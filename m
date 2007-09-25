From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: 2.6.23-rc7-mm1 AHCI ATA errors -- won't boot
Date: Tue, 25 Sep 2007 13:29:03 -0600
Message-ID: <46F9617F.1010508@gmail.com>
References: <46F7FBCB.4030803@gmail.com> <46F8665A.4000206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:48144 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbXIYT3K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Sep 2007 15:29:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2511418wah
        for <linux-ide@vger.kernel.org>; Tue, 25 Sep 2007 12:29:09 -0700 (PDT)
In-Reply-To: <46F8665A.4000206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Jeff Garzik wrote:
> Once the blame has been squared fixed upon me :) you can use git-bisect
> to locate the precise change that broke your setup.

Okay, here's the problem:

268fe6f9f15551be9abedd44a237392675d529d5 is first bad commit
commit 268fe6f9f15551be9abedd44a237392675d529d5
Author: Jeff Garzik <jeff@garzik.org>
Date:   Fri Sep 21 07:09:36 2007 -0400

    [libata] SCSI: simple TEST UNIT READY simulation

    It's trivial to ping the device, and that's a much more sane behavior
    than no-op.

    Signed-off-by: Jeff Garzik <jeff@garzik.org>

:040000 040000 44d34cdad073bd623545b8239aca9a113652c6d0
df6d21f7ce56a4e796f8f856c1f647b0395ab4df M      drivers

Berck
