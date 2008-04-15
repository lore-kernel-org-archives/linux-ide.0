From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6 patch] libata-acpi.c: remove unneeded #if's
Date: Tue, 15 Apr 2008 11:07:42 +0900
Message-ID: <48040DEE.30005@gmail.com>
References: <20080414184040.GC6695@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:55486 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761921AbYDOCHt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2008 22:07:49 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1354595wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2008 19:07:49 -0700 (PDT)
In-Reply-To: <20080414184040.GC6695@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> These #if's are unneeded since they:
> - did anyway not handle the CONFIG_ACPI_DOCK_MODULE case correctly and
> - this is already handled in include/acpi/acpi_drivers.h and
> - it's now correctly handled in kconfig.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

The lesser ifdefs the better.  Acked-by: Tejun Heo <htejun@gmail.com>

Thank you.

-- 
tejun
