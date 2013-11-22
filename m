From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] ata: Fix acpi_bus_get_device() return value check
Date: Fri, 22 Nov 2013 17:39:31 -0500
Message-ID: <CAOS58YNk9DLx-Ps7CYSrMjsbUf68tbHvqsyYbwjWg8c8KkajEw@mail.gmail.com>
References: <1384939706-6292-1-git-send-email-wangyijing@huawei.com>
	<1384939706-6292-4-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:63536 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577Ab3KVWjb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Nov 2013 17:39:31 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so1846681pdi.19
        for <linux-ide@vger.kernel.org>; Fri, 22 Nov 2013 14:39:31 -0800 (PST)
In-Reply-To: <1384939706-6292-4-git-send-email-wangyijing@huawei.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Hanjun Guo <guohanjun@huawei.com>, linux-ide <linux-ide@vger.kernel.org>

On Wed, Nov 20, 2013 at 4:28 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Since acpi_bus_get_device() returns plain int and not acpi_status,
> ACPI_FAILURE() should not be used for checking its return value.  Fix
> that.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org

Applied to libata/for-3.13-fixes.  Thanks.

-- 
tejun
