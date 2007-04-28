From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 10/13] libata-acpi: miscellaneous cleanups
Date: Sat, 28 Apr 2007 15:00:48 -0400
Message-ID: <463399E0.1090002@garzik.org>
References: <11772636663624-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11772636663624-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> * Add missing LOCKING: and RETURNS: to function comment.
> 
> * Don't conditionalize warning messages with ata_msg_probe().  Print
>   directly with KERN_WARNING.
> 
> * Drop duplicate debug messages.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-acpi.c |   51 ++++++++++++++++++++------------------------
>  1 files changed, 23 insertions(+), 28 deletions(-)

ACK


