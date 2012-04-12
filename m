From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [isci PATCH v2 12/18] libata: make ata_print_id atomic
Date: Thu, 12 Apr 2012 15:58:44 -0400
Message-ID: <4F8733F4.5040501@garzik.org>
References: <20120311072518.6320.61717.stgit@dwillia2-linux.jf.intel.com> <20120311072845.6320.68461.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60825 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab2DLT6r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Apr 2012 15:58:47 -0400
In-Reply-To: <20120311072845.6320.68461.stgit@dwillia2-linux.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, Jacek Danecki <jacek.danecki@intel.com>

On 03/11/2012 03:28 AM, Dan Williams wrote:
> This variable is incremented from multiple contexts (module_init via
> libata-lldds and the libsas discovery thread).  Make it atomic to head
> off any chance of libsas and libata creating duplicate ids.
>
> Acked-by: Jacek Danecki<jacek.danecki@intel.com>
> Signed-off-by: Dan Williams<dan.j.williams@intel.com>
> ---
>   drivers/ata/libata-core.c |    4 ++--
>   drivers/ata/libata-scsi.c |    4 ++--
>   drivers/ata/libata.h      |    2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)

applied



