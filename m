From: Tejun Heo <htejun@gmail.com>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Wed, 18 Jul 2007 12:35:53 +0900
Message-ID: <469D8A99.8050102@gmail.com>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com> <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:32997 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbXGRDgB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jul 2007 23:36:01 -0400
Received: by nz-out-0506.google.com with SMTP id s18so47979nze
        for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 20:36:00 -0700 (PDT)
In-Reply-To: <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: flyashi@gmail.com
Cc: linux-ide@vger.kernel.org

Yasha Okshtein wrote:
> I need to send soft and/or hard resets from userspace.

Actually, you can do it by requesting manual rescan of the SCSI host.
"echo - - - > /sys/class/scsi_host/hostX/scan".

-- 
tejun
