From: Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH 1/1] ata_piix: defer disks to the Hyper-V paravirtualised
 drivers by default
Date: Fri, 13 Apr 2012 08:37:45 +0100
Message-ID: <20120413073745.GN3357@shadowen.org>
References: <1333042130-9634-1-git-send-email-apw@canonical.com>
 <4F87351E.9040905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F87351E.9040905@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Apr 12, 2012 at 04:03:42PM -0400, Jeff Garzik wrote:

> Platform quirks should be handled in piix_init_one, not with this
> haphazard read_id callback.  If prefer_ms_hyperv &&
> hypervisor-detected, then set ATA_HOST_IGNORE_ATA flag or similar.

That does sound better.  I'll whip something up.

-apw
