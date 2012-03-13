From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: linux-next: Tree for Mar 13 (ata)
Date: Tue, 13 Mar 2012 17:22:43 -0400
Message-ID: <4F5FBAA3.3080508@pobox.com>
References: <20120313204114.e160849af7dbe5a4b4e5c0ad@canb.auug.org.au> <4F5FB6F0.6050300@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <4F5FB6F0.6050300@xenotime.net>
Sender: linux-scsi-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 03/13/2012 05:06 PM, Randy Dunlap wrote:
> On 03/13/2012 02:41 AM, Stephen Rothwell wrote:
>
>> Hi all,
>>
>> Changes since 20120309:
>
>
> on x86_64:
>
> ERROR: "ata_sas_port_async_resume" [drivers/scsi/libsas/libsas.ko] undefined!
> ERROR: "ata_sas_port_async_suspend" [drivers/scsi/libsas/libsas.ko] undefined!
>
>
> # CONFIG_SUSPEND is not set
> # CONFIG_PM_RUNTIME is not set
> # CONFIG_ACPI is not set

That sounds like the scsi tree (linux-scsi CC added).



