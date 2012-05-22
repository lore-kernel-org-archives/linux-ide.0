From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_generic: Skip is_intel_ider() check when ata_generic=1
 is set
Date: Tue, 22 May 2012 16:04:40 -0400
Message-ID: <4FBBF158.2040001@pobox.com>
References: <1336754003-31487-1-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336754003-31487-1-git-send-email-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, alan@linux.intel.com
List-Id: linux-ide@vger.kernel.org

On 05/11/2012 12:33 PM, Andi Kleen wrote:
> From: Andi Kleen<ak@linux.intel.com>
>
> When ata_generic_ide=1 is set don't do the is_intel_ider() magic
> check. We found at least one box who needed that.
>
> Cc: alan@linux.intel.com
> Signed-off-by: Andi Kleen<ak@linux.intel.com>
> ---
>   drivers/ata/ata_generic.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

applied
