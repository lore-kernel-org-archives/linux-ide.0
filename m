From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH libata/for-3.14-fixes] ahci: disable NCQ on Samsung pci-e
 SSDs on macbooks
Date: Tue, 18 Feb 2014 17:30:17 +0100
Message-ID: <CAAsK9AGgoEMNZytqT3XZF-roqj-4d68_YfFmzxTEdgfYvAxWwQ@mail.gmail.com>
References: <20140218152836.GB30043@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:63829 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbaBRQaS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Feb 2014 11:30:18 -0500
Received: by mail-ve0-f170.google.com with SMTP id cz12so14029075veb.29
        for <linux-ide@vger.kernel.org>; Tue, 18 Feb 2014 08:30:17 -0800 (PST)
In-Reply-To: <20140218152836.GB30043@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

2014-02-18 16:28 GMT+01:00 Tejun Heo <tj@kernel.org>:
> From 67809f85d31eac600f6b28defa5386c9d2a13b1d Mon Sep 17 00:00:00 2001
> From: Levente Kurusa <levex@linux.com>
> Date: Tue, 18 Feb 2014 10:22:17 -0500
>
> Samsung's pci-e SSDs with device ID 0x1600 which are found on some
> macbooks time out on NCQ commands.  Blacklist NCQ on the device so
> that the affected machines can at least boot.
>
> Original-patch-by: Levente Kurusa <levex@linux.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=60731
> Cc: stable@vger.kernel.org
> ---
>  drivers/ata/ahci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> [...]

Thank you for posting this! In case you need my Signed-off-by, here it is:

Signed-off-by: Levente Kurusa <levex@linux.com>

--
Regards,
Levente Kurusa
