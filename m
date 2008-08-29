From: Tejun Heo <htejun@gmail.com>
Subject: Re: Regression: SATA disk double spin-off during hibernation on hp
 nx6325
Date: Fri, 29 Aug 2008 12:03:37 +0200
Message-ID: <48B7C979.1000606@gmail.com>
References: <200808290002.55026.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.244]:24252 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYH2KEu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Aug 2008 06:04:50 -0400
Received: by ag-out-0708.google.com with SMTP id 31so1994138agc.10
        for <linux-ide@vger.kernel.org>; Fri, 29 Aug 2008 03:04:49 -0700 (PDT)
In-Reply-To: <200808290002.55026.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>

Hello,

Rafael J. Wysocki wrote:
> It appears that the "double spin-off" problem described in
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=8855
> 
> has recently started to appear during hibernation as well as during shutdown.
> It didn't appear during hibernation on my hp nx6325 with 2.6.26, so this is a
> recent regression.
> 
> I have prepared the appended patch that fixes the problem for me, based on the
>  earlier Tejun's patch at
> 
> http://bugzilla.kernel.org/attachment.cgi?id=15441&action=view
> 
> but I'm not really sure if this is an acceptable solution.  Please advise.
> 
> Thanks,
> Rafael
> 
> 
> not-yet-signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

The libata part looks fine to me but what are those SYSTEM_SUSPEND_DISK
stuff?  They don't look like belonging to this patch.

Thanks.

-- 
tejun
