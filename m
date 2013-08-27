From: Tejun Heo <tj@kernel.org>
Subject: Re: linux-next: build failure after merge of the libata tree
Date: Tue, 27 Aug 2013 14:09:17 -0400
Message-ID: <20130827180917.GA12212@mtj.dyndns.org>
References: <20130827125049.62d12bba371fe8d9df85a227@canb.auug.org.au>
 <521C3E89.3090905@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <521C3E89.3090905@intel.com>
Sender: linux-next-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Aug 27, 2013 at 01:52:09PM +0800, Aaron Lu wrote:
> From: Aaron Lu <aaron.lu@intel.com>
> Subject: [PATCH] ata: acpi: Remove ata_dev_acpi_handle stub in libata.h
> 
> The ata_dev_acpi_handle is defined in libata-acpi.c and the only
> external user is libata-zpodd.c, which is built when CONFIG_ATA_ACPI
> is set, so there is no need to make an empty stub function for
> !CONFIG_ATA_ACPI case in libata.h. It also causes compile errors due to
> acpi_handle is not defined when !CONFIG_ACPI. This patch fixes this
> problem by removing the empty stub.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Yeap, tested and works.  Applied to libata/for-3.12.  Thanks.

Stephen, sorry about the trouble.

-- 
tejun
