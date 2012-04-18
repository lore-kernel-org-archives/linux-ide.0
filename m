From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 22:28:21 -0400
Message-ID: <4F8E26C5.2060901@pobox.com>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com> <4F8DD939.1050909@pobox.com> <4F8DDB24.9080109@teksavvy.com> <4F8DDC4F.8060103@pobox.com> <CAF1ivSZwpW78RMFnNmhcm3Ntwz1ua1gEbK0PFttKwfhWQ8MDXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48844 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab2DRC2X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 22:28:23 -0400
Received: by qcro28 with SMTP id o28so4245036qcr.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2012 19:28:23 -0700 (PDT)
In-Reply-To: <CAF1ivSZwpW78RMFnNmhcm3Ntwz1ua1gEbK0PFttKwfhWQ8MDXw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 04/17/2012 09:52 PM, Lin Ming wrote:
> I'm working on the hotplug issue fix.
> How about below suggestion:
>
> 1) forbid port runtime pm by default, user can allow it on demand by
> sysfs interface
> 2) then driver to allow port runtime pm if it supports hotplug well

That seems reasonable.

	Jeff




