From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version
 4
Date: Tue, 02 Oct 2007 16:38:19 -0400
Message-ID: <4702AC3B.2010004@garzik.org>
References: <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com> <20070924231436.GA32119@srcf.ucam.org> <47025E09.1030803@garzik.org> <20071002184958.GC31251@srcf.ucam.org> <47029423.6030605@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <47029423.6030605@garzik.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kristen.c.accardi@intel.com
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Matthew Garrett wrote:
>> Modern laptops with hotswap bays still tend to utilise a PATA=20
>> interface on a SATA bridge, generally with the host controller in so=
me=20
>> legacy emulation mode rather than AHCI. This means that the existing=
=20
>> hotplug code in libata is unable to work. The ACPI specification=20
>> states that these devices can send notifications when hotswapped,=20
>> which avoids the need to obtain notification from the controller. Th=
is=20
>> patch uses the existing libata-acpi code and simply registers a=20
>> notification in order to trigger a rescan whenever the firmware=20
>> signals an event.
>>                                                                     =
                                                                       =
                                                            =20
>> Signed-off-by: Matthew Garrett=20
>> <mjg59@srcf.ucam.org>                      =20
>> ---
>>
>> This incorporates Jeff's feedback. sdev is checked for NULL, and=20
>> different notifications are registered for ap-level and dev-level=20
>> handlers. The core code is split out into a helper function called b=
y=20
>> both of these. The other change is the removal of the extraneous=20
>> newline from the end of the notification event, to match the upstrea=
m=20
>> change in the bay driver.
>=20
> applied

Come on, dude!  This doesn't even build:

   UPD     include/linux/compile.h
drivers/ata/libata-acpi.c: In function =91ata_acpi_handle_hotplug=92:
drivers/ata/libata-acpi.c:104: error: =91struct ata_port=92 has no memb=
er=20
named =91eh_info=92
drivers/ata/libata-acpi.c: In function =91ata_acpi_dev_notify=92:
drivers/ata/libata-acpi.c:130: error: =91struct ata_device=92 has no me=
mber=20
named =91ap=92
drivers/ata/libata-acpi.c: In function =91ata_acpi_associate=92:
drivers/ata/libata-acpi.c:178: error: implicit declaration of function=20
=91ata_port_max_devices=92
drivers/ata/libata-acpi.c:179: error: =91struct ata_port=92 has no memb=
er=20
named =91device=92
make[2]: *** [drivers/ata/libata-acpi.o] Error 1


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
