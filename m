From: Tejun Heo <tj@kernel.org>
Subject: Re: kernel crash with lite-on sata controller Dell XPS 13 9343
Date: Thu, 25 Feb 2016 17:01:57 -0500
Message-ID: <CAOS58YNe5Jw-OiDHs6t-uUN8n0c-8LkJYFbVLQ4TjGtMtsTJgw@mail.gmail.com>
References: <56CF75E6.5070803@gmail.com>
	<20160225215130.GK6092@mtj.duckdns.org>
	<56CF77CE.2040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34241 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbcBYWB6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Feb 2016 17:01:58 -0500
Received: by mail-io0-f179.google.com with SMTP id 9so98335086iom.1
        for <linux-ide@vger.kernel.org>; Thu, 25 Feb 2016 14:01:57 -0800 (PST)
In-Reply-To: <56CF77CE.2040204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carolin Latze <carolin.latze@gmail.com>
Cc: Hans De Goede <hdegoede@redhat.com>, linux-ide <linux-ide@vger.kernel.org>

Hello, Carolin.

On Thu, Feb 25, 2016 at 4:53 PM, Carolin Latze <carolin.latze@gmail.com> wrote:
> Hi Tejun
>
> I actually boot with "libata.force=noncq,1.5G". Sorry, forgot to mention
> that. Same behavior.

Can you please post screen capture from that failure?

Thanks.

-- 
tejun
