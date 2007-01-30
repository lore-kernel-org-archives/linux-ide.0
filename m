From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata driver fails to work after resume from S3
Date: Tue, 30 Jan 2007 12:09:51 +0900
Message-ID: <45BEB6FF.7090504@gmail.com>
References: <1169797602.25758.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:47443 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964860AbXA3DKH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jan 2007 22:10:07 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1527491nze
        for <linux-ide@vger.kernel.org>; Mon, 29 Jan 2007 19:10:07 -0800 (PST)
In-Reply-To: <1169797602.25758.85.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: jgarzik@pobox.com, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

Zhang Rui wrote:
> But how to make SATA drive S3 work properly in 2.6.16.33?

There is no simple patch which can fix S3 support in 2.6.16.  You need
to backport whole libata EH including PM support.  If you absolutely
have to keep using 2.6.16.33, consider backporting libata as a whole
from 2.6.19 (it wouldn't be easy unless you're familiar with libata and
SCSI).  Otherwise, just use kernel >= 2.6.18.

-- 
tejun
