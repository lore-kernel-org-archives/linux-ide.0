From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: restore acpi disable functionality
Date: Sun, 2 Dec 2012 06:18:08 -0800
Message-ID: <20121202141808.GR15930@mtj.dyndns.org>
References: <50B3044D.4020209@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50B3044D.4020209@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Dimitris Damigos <damigos@freemail.gr>, Matthew Garrett <mjg@redhat.com>, Holger Macht <holger@homac.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Nov 26, 2012 at 01:55:25PM +0800, Aaron Lu wrote:
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

Acked-by: Tejun Heo <tj@kernel.org>

Jeff?

Thanks.

-- 
tejun
