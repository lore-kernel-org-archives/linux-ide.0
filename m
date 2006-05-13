From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 09/11] ahci: convert to new EH
Date: Sat, 13 May 2006 19:53:45 +0900
Message-ID: <4465BAB9.1030307@gmail.com>
References: <1147353689306-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:24820 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932318AbWEMKxw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 06:53:52 -0400
Received: by py-out-1112.google.com with SMTP id x31so1008216pye
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 03:53:51 -0700 (PDT)
In-Reply-To: <1147353689306-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert AHCI to new EH.  Unfortunately, ICH7 AHCI reacts badly if IRQ
> mask is diddled during operation.  So, freezing is implemented by
> unconditionally clearing interrupt conditions while frozen.

I've been testing AHCI EH again for PM and it seems I might have 
confused device problem and HBA problem when implementing AHCI EH the 
first time.  I'm still verifying things bug IRQ diddling doesn't seems 
to cause any problem.

Please don't pull this patchset till things are verified.

-- 
tejun
