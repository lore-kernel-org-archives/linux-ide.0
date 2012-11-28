From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: reenable MS Virtual PC guests
Date: Wed, 28 Nov 2012 12:44:07 -0500
Message-ID: <50B64D67.3080202@pobox.com>
References: <1347983281-15422-1-git-send-email-olaf@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347983281-15422-1-git-send-email-olaf@aepfle.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, KY Srinivasan <kys@microsoft.com>
List-Id: linux-ide@vger.kernel.org

On 09/18/2012 11:48 AM, Olaf Hering wrote:
> An earlier commit cd006086fa5d91414d8ff9ff2b78fbb593878e3c ("ata_piix:
> defer disks to the Hyper-V drivers by default") broke MS Virtual PC
> guests. Hyper-V guests and Virtual PC guests have nearly identical DMI
> info. As a result the driver does currently ignore the emulated hardware
> in Virtual PC guests and defers the handling to hv_blkvsc. Since Virtual
> PC does not offer paravirtualized drivers no disks will be found in the
> guest.
>
> One difference in the DMI info is the product version. This patch adds a
> match for MS Virtual PC 2007 and "unignores" the emulated hardware.
>
> This was reported for openSuSE 12.1 in bugzilla:
> https://bugzilla.novell.com/show_bug.cgi?id=737532
>
> Here is a detailed list of DMI info from example guests:
>
> hwinfo --bios:
>
> virtual pc guest:
>
>    System Info: #1
>      Manufacturer: "Microsoft Corporation"
>      Product: "Virtual Machine"
>      Version: "VS2005R2"
>      Serial: "3178-9905-1533-4840-9282-0569-59"
>      UUID: undefined, but settable
>      Wake-up: 0x06 (Power Switch)
>    Board Info: #2
>      Manufacturer: "Microsoft Corporation"
>      Product: "Virtual Machine"
>      Version: "5.0"
>      Serial: "3178-9905-1533-4840-9282-0569-59"
>    Chassis Info: #3
>      Manufacturer: "Microsoft Corporation"
>      Version: "5.0"
>      Serial: "3178-9905-1533-4840-9282-0569-59"
>      Asset Tag: "7188-3705-6309-9738-9645-0364-00"
>      Type: 0x03 (Desktop)
>      Bootup State: 0x03 (Safe)
>      Power Supply State: 0x03 (Safe)
>      Thermal State: 0x01 (Other)
>      Security Status: 0x01 (Other)
>
> win2k8 guest:
>
>    System Info: #1
>      Manufacturer: "Microsoft Corporation"
>      Product: "Virtual Machine"
>      Version: "7.0"
>      Serial: "9106-3420-9819-5495-1514-2075-48"
>      UUID: undefined, but settable
>      Wake-up: 0x06 (Power Switch)
>    Board Info: #2
>      Manufacturer: "Microsoft Corporation"
>      Product: "Virtual Machine"
>      Version: "7.0"
>      Serial: "9106-3420-9819-5495-1514-2075-48"
>    Chassis Info: #3
>      Manufacturer: "Microsoft Corporation"
>      Version: "7.0"
>      Serial: "9106-3420-9819-5495-1514-2075-48"
>      Asset Tag: "7076-9522-6699-1042-9501-1785-77"
>      Type: 0x03 (Desktop)
>      Bootup State: 0x03 (Safe)
>      Power Supply State: 0x03 (Safe)
>      Thermal State: 0x01 (Other)
>      Security Status: 0x01 (Other)
>
> win2k12 guest:
>
>    System Info: #1
>      Manufacturer: "Microsoft Corporation"
>      Product: "Virtual Machine"
>      Version: "7.0"
>      Serial: "8179-1954-0187-0085-3868-2270-14"
>      UUID: undefined, but settable
>      Wake-up: 0x06 (Power Switch)
>    Board Info: #2
>      Manufacturer: "Microsoft Corporation"
>      Product: "Virtual Machine"
>      Version: "7.0"
>      Serial: "8179-1954-0187-0085-3868-2270-14"
>    Chassis Info: #3
>      Manufacturer: "Microsoft Corporation"
>      Version: "7.0"
>      Serial: "8179-1954-0187-0085-3868-2270-14"
>      Asset Tag: "8374-0485-4557-6331-0620-5845-25"
>      Type: 0x03 (Desktop)
>      Bootup State: 0x03 (Safe)
>      Power Supply State: 0x03 (Safe)
>      Thermal State: 0x01 (Other)
>      Security Status: 0x01 (Other)
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

applied.  Apologies for missing this one.  It was accidentally shifting 
into the low-priority pile.
