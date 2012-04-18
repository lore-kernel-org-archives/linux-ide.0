From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 21:37:35 -0400
Message-ID: <4F8E1ADF.3060606@teksavvy.com>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com>  <4F8DD939.1050909@pobox.com> <4F8DDB24.9080109@teksavvy.com>  <4F8DDC4F.8060103@pobox.com> <4F8DDDC0.2010609@teksavvy.com>  <CAF1ivSbEWJ18vV1ZqTnzWuZ5AXKwj+0pPPzCWUmnT_JKwKKQ2w@mail.gmail.com> <1334712587.11188.139.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:41978 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab2DRBhh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 21:37:37 -0400
In-Reply-To: <1334712587.11188.139.camel@minggr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On 12-04-17 09:29 PM, Lin Ming wrote:
>
> I'm working on the hotplug issue fix.
> 
> Before the fix is ready, here is the one-line patch.
> Could you give it a try?
..
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
>  	device_enable_async_suspend(dev);
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> +	pm_runtime_forbid(dev);
>  
..

I'm rebuilding the kernel right now.. should take about 5min or less to test.

