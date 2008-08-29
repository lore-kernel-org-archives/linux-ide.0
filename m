From: Tejun Heo <htejun@gmail.com>
Subject: Re: Regression: SATA disk double spin-off during hibernation on hp
 nx6325
Date: Fri, 29 Aug 2008 12:42:14 +0200
Message-ID: <48B7D286.7050104@gmail.com>
References: <200808290002.55026.rjw@sisk.pl> <48B7C979.1000606@gmail.com> <200808291241.04183.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.241]:26867 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYH2KnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Aug 2008 06:43:24 -0400
Received: by ag-out-0708.google.com with SMTP id 31so2028566agc.10
        for <linux-ide@vger.kernel.org>; Fri, 29 Aug 2008 03:43:24 -0700 (PDT)
In-Reply-To: <200808291241.04183.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>

Rafael J. Wysocki wrote:
> Actaully, they do belong to it.  This is the part "fixing" the hibernation code
> path, in which the disk is also powered off unnecessarily.
> 
> Well, probably I should use SYSTEM_HIBERNATE_ENTER or something similar
> instead of SYSTEM_SUSPEND_DISK.
> 
> In short, the idea is to change system_state to something specific to the last
> phase of hibernation (after saving the image) and check that in
> ata_scsi_start_stop_xlat().  In fact that's completely analogous to what's done
> for SYSTEM_POWER_OFF in there.

Ah.. right, missed the added check for SUSPEND_DISK in libata-scsi.c.
Maybe it's a good idea to note it in the commit message later?

Thanks.

-- 
tejun
