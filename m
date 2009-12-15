From: Grant Grundler <grundler@google.com>
Subject: Re: NCQ high speed data integrity issues
Date: Tue, 15 Dec 2009 12:47:11 -0800
Message-ID: <da824cf30912151247r14c4e29cp6c97421683d82eb2@mail.gmail.com>
References: <93b143da0912151129obdf3613q558295b320e4db65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 216-239-44-51.google.com ([216.239.44.51]:32857 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbZLOUrQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Dec 2009 15:47:16 -0500
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id nBFKlFaI007140
	for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 12:47:15 -0800
Received: from ey-out-1920.google.com (eyg4.prod.google.com [10.208.7.4])
	by wpaz21.hot.corp.google.com with ESMTP id nBFKlCOV025414
	for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 12:47:13 -0800
Received: by ey-out-1920.google.com with SMTP id 4so76433eyg.26
        for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 12:47:12 -0800 (PST)
In-Reply-To: <93b143da0912151129obdf3613q558295b320e4db65@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Porat <dan.porat@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, Dec 15, 2009 at 11:29 AM, Dan Porat <dan.porat@gmail.com> wrote:
> I am running into data integrity issues while running sgp_dd ver 1.20
> against any sg device while running 31 threads.
> kernel 2.6.28 Ubuntu.
> When running it in slow speed (20 MB/s) all runs well.
> When pushing it towards the 50MB/s , Data integrity issues appear.

How are you varying the speed?

> When running it against sd devices - no integrity issues , but bpt is
> not determined and changes .

Hrm? bpt is a parameter. What do you mean?

I don't know offhand why sg vs sd would make a difference but it's
obviously of interest.

> Any idea how to fix the sg data integrity issues?

Can you post Good vs Bad data?
Knowing the offset, size, and type of corruption will help narrow down
possible sources of corruption.

Any errors reported by the device driver, memory controller, sg device?

cheers,
grant
