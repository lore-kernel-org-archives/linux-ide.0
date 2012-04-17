From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 16:50:51 -0400
Message-ID: <4F8DD7AB.2050709@pobox.com>
References: <4F8DD4DC.4050503@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50197 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2DQUu4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 16:50:56 -0400
Received: by qcro28 with SMTP id o28so4106979qcr.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2012 13:50:55 -0700 (PDT)
In-Reply-To: <4F8DD4DC.4050503@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Lin Ming <ming.m.lin@intel.com>

On 04/17/2012 04:38 PM, Mark Lord wrote:
> Okay, so why isn't SATA hotplug working in linux-3.3.2 ?
> I don't know when it stopped working, but it's a blooming pain in the sysadmin.
>
> I need to hotplug a SATA drive into an AHCI port,
> preferably without having to reboot first.
>
> Is there a patch available already for this regression?

hrm...  smells like runtime PM stuff.

Can you try "libata: disable runtime pm for hotpluggable port"?

You probably have to edit ahci_port_pluggable() to make it 
unconditionally return true.

	Jeff


