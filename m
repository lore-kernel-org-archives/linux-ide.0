From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sg/libata hotplug kernel error
Date: Wed, 09 Jan 2008 11:33:18 +0900
Message-ID: <4784326E.4070404@gmail.com>
References: <8202f4270801021417n2d7fdffbg9eaa33829eeca475@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:10928 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758163AbYAICdZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 21:33:25 -0500
Received: by wa-out-1112.google.com with SMTP id v27so105120wah.23
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 18:33:24 -0800 (PST)
In-Reply-To: <8202f4270801021417n2d7fdffbg9eaa33829eeca475@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Fajun Chen wrote:
> Hi All,
> 
> Has anyone seen this kernel error before? The controller is Sil3124
> and kernel version 2.6.18-rc2.  This seems to happen very rarely since
> this is the first time I 've seen this error message. Thanks for your
> feedback!

2.6.18?  Sadly, you're on your own && there have been lots of hotplug
related fixes since then.  :-(

-- 
tejun
