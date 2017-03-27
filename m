From: Tejun Heo <tj@kernel.org>
Subject: Re: ata: WARNING in ata_bmdma_qc_issue
Date: Mon, 27 Mar 2017 14:03:32 -0400
Message-ID: <20170327180332.GD13353@htj.duckdns.org>
References: <CACT4Y+b+t9TPkVhZPdoeSGfe3rujUdv267HW8yPqoTbKtLUScA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35412 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdC0SEN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Mar 2017 14:04:13 -0400
Content-Disposition: inline
In-Reply-To: <CACT4Y+b+t9TPkVhZPdoeSGfe3rujUdv267HW8yPqoTbKtLUScA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>

On Fri, Mar 24, 2017 at 03:14:14PM +0100, Dmitry Vyukov wrote:
> Hello,
> 
> The following program triggers WARNING in ata_bmdma_qc_issue:
> https://gist.githubusercontent.com/dvyukov/7497a05853e58598b74a2c48030c41f4/raw/38885f75eb05f72bb47fff9c9de657728f529927/gistfile1.txt

Fix is already queued in libata/for-4.11-fixes.  Will be pushed out soon.

Thanks.

-- 
tejun
