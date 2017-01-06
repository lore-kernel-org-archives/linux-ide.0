From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: ahci_xgene: free structure returned by
 acpi_get_object_info()
Date: Fri, 6 Jan 2017 11:39:48 -0500
Message-ID: <20170106163948.GB16083@mtj.duckdns.org>
References: <20170105141401.4896-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35521 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754063AbdAFQjw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jan 2017 11:39:52 -0500
Content-Disposition: inline
In-Reply-To: <20170105141401.4896-1-kernel@kempniu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 05, 2017 at 03:14:01PM +0100, Michał Kępień wrote:
> acpi_get_object_info() allocates the returned structure, which the
> caller has to free when the call succeeds.  Free it when appropriate.
> 
> Fixes: c9802a4be661 ("ata: ahci_xgene: Add AHCI Support for 2nd HW version of APM X-Gene SoC AHCI SATA Host controller.")
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
