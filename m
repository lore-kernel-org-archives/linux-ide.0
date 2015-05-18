From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch] ata: ahci_xgene: potential NULL dereference in probe
Date: Mon, 18 May 2015 16:44:05 -0400
Message-ID: <20150518204405.GH24861@htj.duckdns.org>
References: <20150515092415.GA21508@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150515092415.GA21508@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Suman Tripathi <stripathi@apm.com>, linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, May 15, 2015 at 12:24:15PM +0300, Dan Carpenter wrote:
> Smatch complains about this potential NULL dereference of "acpi_id".
> 
> Fixes: c9802a4be661 ('ata: ahci_xgene: Add AHCI Support for 2nd HW version of APM X-Gene SoC AHCI SATA Host controller.')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to libata/for-4.2.

Thanks.

-- 
tejun
