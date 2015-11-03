From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 0/2] ahci per-port msix support
Date: Tue, 3 Nov 2015 14:35:41 -0800
Message-ID: <CAPcyv4ir7Wn1VS--NA=K3Lc6Yes5wHaq-7tLZEo9sLmsiQsQrw@mail.gmail.com>
References: <20151101184335.23222.22225.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20151102192302.GD9553@mtj.duckdns.org>
	<20151103223220.GF5749@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36694 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964839AbbKCWfm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Nov 2015 17:35:42 -0500
Received: by wicfx6 with SMTP id fx6so78697364wic.1
        for <linux-ide@vger.kernel.org>; Tue, 03 Nov 2015 14:35:41 -0800 (PST)
In-Reply-To: <20151103223220.GF5749@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Nov 3, 2015 at 2:32 PM, Tejun Heo <tj@kernel.org> wrote:
> On Mon, Nov 02, 2015 at 02:23:02PM -0500, Tejun Heo wrote:
>> On Sun, Nov 01, 2015 at 01:43:35PM -0500, Dan Williams wrote:
>> > Changes since v1 [1]:
>> >
>> > 1/ Clean up "nvec = min(nvec, n_ports);" statement (Tejun)
>> >
>> > 2/ Drop threaded interrupt handling option for now.
>> >
>> > [1]: http://marc.info/?l=linux-ide&m=144623970817213&w=2
>>
>> Applied to libata/for-4.4.
>
> Dan, I got the following build failures from kbuild and reverted the
> two patches from for-4.4.  It's too late for this merge window anyway.
> Let's try the next one.
>

Ok, I'll resend after -rc1 is sent out.
