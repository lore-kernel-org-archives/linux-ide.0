From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] new Power Management for libata
Date: Mon, 19 Jun 2006 17:46:27 +0900
Message-ID: <44966463.2020300@gmail.com>
References: <11501274284082-git-send-email-htejun@gmail.com>	 <448F659A.5010606@pobox.com>  <44901325.7050902@gmail.com> <1150694318.7132.104.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:21656 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751240AbWFSIq2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jun 2006 04:46:28 -0400
Received: by py-out-1112.google.com with SMTP id i49so1198588pye
        for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2006 01:46:28 -0700 (PDT)
In-Reply-To: <1150694318.7132.104.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

> Jeff and Tejun,
> 
> Have we achieved a consensus about this new PM patches? The AHCI
> suspend/resume patch and ACPI-SATA patch will definitely depend on this
> new PM.

The consensus seems to be me doing another round of this patchset w/ 
per-dev PM support.  I'm currently working on it.  I don't think it will 
take more than a few days.

Thanks.

-- 
tejun
