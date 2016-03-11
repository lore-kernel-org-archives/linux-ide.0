From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch] ata: ahci_xgene: dereferencing uninitialized pointer in
 probe
Date: Fri, 11 Mar 2016 12:41:04 -0500
Message-ID: <20160311174104.GH24046@htj.duckdns.org>
References: <20160310074532.GA7163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35360 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbcCKRlH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Mar 2016 12:41:07 -0500
Content-Disposition: inline
In-Reply-To: <20160310074532.GA7163@mwanda>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Suman Tripathi <stripathi@apm.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Mar 10, 2016 at 10:45:32AM +0300, Dan Carpenter wrote:
> If the call to acpi_get_object_info() fails then "info" hasn't been
> initialized.  In that situation, we already know that "version" should
> be XGENE_AHCI_V1 so we don't actually need to dereference "info".
> 
> Fixes: c9802a4be661 ('ata: ahci_xgene: Add AHCI Support for 2nd HW version of APM X-Gene SoC AHCI SATA Host controller.')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to libata/for-4.6.

Thanks.

-- 
tejun
