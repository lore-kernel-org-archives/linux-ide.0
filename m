From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/3] ahci-remap.h: add ahci remapping definitions
Date: Sat, 3 Dec 2016 13:57:01 +0300
Message-ID: <aa6cba2c-6cf7-0222-b871-d98d1c8e4fe8@cogentembedded.com>
References: <1480703463-17489-1-git-send-email-hch@lst.de>
 <1480703463-17489-3-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36070 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbcLCK5E (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 3 Dec 2016 05:57:04 -0500
Received: by mail-lf0-f50.google.com with SMTP id t196so212336726lff.3
        for <linux-ide@vger.kernel.org>; Sat, 03 Dec 2016 02:57:03 -0800 (PST)
In-Reply-To: <1480703463-17489-3-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, tj@kernel.org
Cc: dan.j.williams@intel.com, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org

Hello.

On 12/2/2016 9:31 PM, Christoph Hellwig wrote:

> From: Dan Williams <dan.j.williams@intel.com>
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> [hch: split into a separate header and commit]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/ahci-remap.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 include/linux/ahci-remap.h
>
> diff --git a/include/linux/ahci-remap.h b/include/linux/ahci-remap.h
> new file mode 100644
> index 0000000..883d366
> --- /dev/null
> +++ b/include/linux/ahci-remap.h
> @@ -0,0 +1,29 @@
> +#ifndef _LINUX_AHCI_REMAP_H
> +#define _LINUX_AHCI_REMAP_H
> +
> +#include <linux/sizes.h>
> +
> +#define AHCI_VSCAP		0xa4
> +#define AHCI_REMAP_CAP		0x800
> +#define AHCI_VSCAP		0xa4

    Why do it twice?

MBR, Sergei

