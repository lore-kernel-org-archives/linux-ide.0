From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: ahci_platform: Add ACPI support for AMD Seattle SATA controller
Date: Mon, 29 Sep 2014 20:16:05 +0200
Message-ID: <4070982.j4ECbq7XE2@wuerfel>
References: <1410295035-14471-1-git-send-email-suravee.suthikulpanit@amd.com> <CAOesGMh_Ku-pReg5LHVFvRM0-s_zEO4rgAvaD5rv-eTfPD71Yw@mail.gmail.com> <542882E3.2050908@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <542882E3.2050908@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sunday 28 September 2014 16:51:31 Suravee Suthikulpanit wrote:
> >> @@ -87,6 +90,13 @@ static const struct of_device_id ahci_of_match[] = {
> >>   };
> >>   MODULE_DEVICE_TABLE(of, ahci_of_match);
> >>
> >> +#ifdef CONFIG_ATA_ACPI
> >> +static const struct acpi_device_id ahci_acpi_match[] = {
> >> +       { "AMDI0600", 0 }, /* AMD Seattle AHCI */
> >> +       { },
> >> +};
> >> +#endif
> >> +

I just noticed this patch and stumbled over this hack. Since SBSA requires
any SATA support to be compatible with AHCI and not vendor specific, I think
this needs to be a more generic compatibility string that can be used by
all vendors, while the current one looks very AMD specific for hardware
that is not.

	Arnc
