From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] ahci: don't use MSI for devices with the braindead Intel
 NVMe remapping scheme
Date: Tue, 5 Sep 2017 09:55:01 -0700
Message-ID: <CAA9_cmdfExRp4z6=L_2H2O69JfN4RjMPV8qBzgO2LxVyWzNWUQ@mail.gmail.com>
References: <20170905164647.24101-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33706 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbdIEQzC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2017 12:55:02 -0400
In-Reply-To: <20170905164647.24101-1-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, john.robert.loy@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@vger.kernel.org

On Tue, Sep 5, 2017 at 9:46 AM, Christoph Hellwig <hch@lst.de> wrote:
> Intel AHCI controllers that also hide NVMe devices in their bar
> can't use MSI interrupts, so disable them.
>
> Reported-by: John Loy <john.robert.loy@gmail.com>
> Testd-by: John Loy <john.robert.loy@gmail.com>

s/Testd-by/Tested-by/

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org

Acked-by: Dan Williams <dan.j.williams@intel.com>

Please also make the subject-line drier.
