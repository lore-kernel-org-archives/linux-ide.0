From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v4 04/13] libata: use correct PCI devices
Date: Tue, 29 May 2012 16:22:24 +0400
Message-ID: <4FC4BF80.2090900@mvista.com>
References: <1338181720-4149-1-git-send-email-ming.m.lin@intel.com> <1338181720-4149-5-git-send-email-ming.m.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53876 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab2E2MW4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 May 2012 08:22:56 -0400
Received: by lbbgm6 with SMTP id gm6so2488922lbb.19
        for <linux-ide@vger.kernel.org>; Tue, 29 May 2012 05:22:55 -0700 (PDT)
In-Reply-To: <1338181720-4149-5-git-send-email-ming.m.lin@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <David.Woodhouse@intel.com>, Aaron Lu <aaron.lu@amd.com>, Holger Macht <holger@homac.de>, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

Hello.

On 28-05-2012 9:08, Lin Ming wrote:

> From: Holger Macht<holger@homac.de>

> Commit 9a6d6a2ddabbd32c07f6a38b659e5f3db319fa5a

    Please also specify that commit's summary in parens.

> made ata ports parent
> devices of scsi hosts, so we need to go yet another level up to be able
> to use the correct PCI devices.

> Signed-off-by: Holger Macht <holger@homac.de>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>

WBR, Sergei
