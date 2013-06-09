From: Liu Yu <liuyu.ac@gmail.com>
Subject: Re: [PATCH] ahci: remove pmp link online check in FBS EH
Date: Sun, 9 Jun 2013 17:59:39 +0800
Message-ID: <CAASYz_SrLOYfrmgo2O0nGVquwfawbcdUk6j+xTGKzVYo7epqRQ@mail.gmail.com>
References: <1370678416-2133-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:62907 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab3FIJ7k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Jun 2013 05:59:40 -0400
In-Reply-To: <1370678416-2133-1-git-send-email-shane.huang@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, stable@vger.kernel.org

On Sat, Jun 8, 2013 at 4:00 PM, Shane Huang <shane.huang@amd.com> wrote:
>
> ata_link_online() check in ahci_error_intr() is unnecessary, it should
> be removed otherwise may lead to lockup with FBS enabled PMP.
> http://marc.info/?l=linux-ide&m=137050421603272&w=2
>

This works for me.
Thanks Shane and Tejun!

Liu Yu
