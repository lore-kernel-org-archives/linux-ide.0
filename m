From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 199/493] ata: remove use of __devinit
Date: Tue, 20 Nov 2012 08:38:56 +0530
Message-ID: <CAOh2x=k7+FtiVbbv-cEvwjTLOa0rsnNue5hqZ_81DvS99ozVyQ@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-199-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42645 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab2KTDI4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2012 22:08:56 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so1942033vcm.19
        for <linux-ide@vger.kernel.org>; Mon, 19 Nov 2012 19:08:56 -0800 (PST)
In-Reply-To: <1353349642-3677-199-git-send-email-wfp5p@virginia.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, "...)" <linux-ide@vger.kernel.org>

On Mon, Nov 19, 2012 at 11:52 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: linux-ide@vger.kernel.org ...)
> ---
>  drivers/ata/pata_arasan_cf.c   |  2 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
