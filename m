From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 038/493] ata: remove use of __devexit_p
Date: Tue, 20 Nov 2012 08:36:56 +0530
Message-ID: <CAOh2x=nKNc+Zv5KP8xW9Wf5NYs5k8pxQjPOJ=jRkoo_Ni3yjXw@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-38-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48185 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab2KTDG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2012 22:06:57 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so1940843vcm.19
        for <linux-ide@vger.kernel.org>; Mon, 19 Nov 2012 19:06:56 -0800 (PST)
In-Reply-To: <1353349642-3677-38-git-send-email-wfp5p@virginia.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, "...)" <linux-ide@vger.kernel.org>, spear-devel <spear-devel@list.st.com>

On Mon, Nov 19, 2012 at 11:49 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: linux-ide@vger.kernel.org ...)
> ---
>  drivers/ata/pata_arasan_cf.c   | 2 +-

For pata_arasan:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
