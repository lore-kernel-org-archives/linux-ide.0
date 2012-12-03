From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: restore acpi disable functionality
Date: Mon, 03 Dec 2012 04:58:40 -0500
Message-ID: <50BC77D0.8040306@pobox.com>
References: <50B3044D.4020209@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <50B3044D.4020209@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Dimitris Damigos <damigos@freemail.gr>, Tejun Heo <tj@kernel.org>, Matthew Garrett <mjg@redhat.com>, Holger Macht <holger@homac.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>
List-Id: linux-ide@vger.kernel.org

On 11/26/2012 12:55 AM, Aaron Lu wrote:
>
> Commit 66fa7f215 "libata-acpi: improve ACPI disabling" introdcued the
> behaviour of disabling ATA ACPI if ata_acpi_on_devcfg failed the 2nd
> time, but commit 30dcf76ac dropped this behaviour and this caused
> problem for Dimitris Damigos, where his laptop can not resume correctly.
>
> The bugzilla page for it is:
> https://bugzilla.kernel.org/show_bug.cgi?id=49331
>
> The problem is, ata_dev_push_id will fail the 2nd time it is invoked,
> and due to disabling ACPI code is dropped, ata_acpi_on_devcfg which
> calls ata_dev_push_id will keep failing and eventually made the device
> disabled.
>
> This patch restores the original behaviour, if acpi failed the 2nd time,
> disable acpi functionality for the device(and we do not event need to
> add a debug message for this as it is still there ;-).
>
> Reported-by: Dimitris Damigos <damigos@freemail.gr>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>   drivers/ata/libata-acpi.c | 4 ++++
>   include/linux/libata.h    | 1 +
>   2 files changed, 5 insertions(+)

applied



