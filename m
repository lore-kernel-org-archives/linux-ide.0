From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 1/3] ACPI / bind: Rework struct acpi_bus_type
Date: Fri, 29 Nov 2013 09:55:07 +0800
Message-ID: <5297F3FB.6030808@intel.com>
References: <4501334.ovACrGogrl@vostro.rjw.lan> <2273591.1tQV675JFy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <2273591.1tQV675JFy@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Aaron Lu <aaron.lu@intel.com>, Toshi Kani <toshi.kani@hp.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-ide@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 2013=E5=B9=B411=E6=9C=8829=E6=97=A5 08:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Replace the .find_device function pointer in struct acpi_bus_type
> with a new one, .find_copmanion, that is supposed to point to a
-------------------------^
A typo

> function returning struct acpi_device pointer (instead of an int)
> and takes one argument (instead of two).  This way the role of
> this callback is more clear and the implementation of it can
> be more straightforward.
>=20
> Update all of the users of struct acpi_bus_type (PCI, PNP/ACPI and
> USB) to reflect the structure change.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/glue.c         |   12 +++++++-----
>  drivers/pci/pci-acpi.c      |   12 +++---------
>  drivers/pnp/pnpacpi/core.c  |   19 +++++--------------
>  drivers/usb/core/usb-acpi.c |   40 ++++++++++++++++++++-------------=
-------
>  include/acpi/acpi_bus.h     |    2 +-
>  5 files changed, 36 insertions(+), 49 deletions(-)
>=20
> Index: linux-pm/include/acpi/acpi_bus.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -414,7 +414,7 @@ struct acpi_bus_type {
>  	struct list_head list;
>  	const char *name;
>  	bool (*match)(struct device *dev);
> -	int (*find_device) (struct device *, acpi_handle *);
> +	struct acpi_device * (*find_companion)(struct device *);
>  	void (*setup)(struct device *);
>  	void (*cleanup)(struct device *);
>  };
> Index: linux-pm/drivers/acpi/glue.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/glue.c
> +++ linux-pm/drivers/acpi/glue.c
> @@ -37,7 +37,7 @@ int register_acpi_bus_type(struct acpi_b
>  {
>  	if (acpi_disabled)
>  		return -ENODEV;
> -	if (type && type->match && type->find_device) {
> +	if (type && type->match && type->find_companion) {
>  		down_write(&bus_type_sem);
>  		list_add_tail(&type->list, &bus_type_list);
>  		up_write(&bus_type_sem);
> @@ -302,17 +302,19 @@ EXPORT_SYMBOL_GPL(acpi_unbind_one);
>  static int acpi_platform_notify(struct device *dev)
>  {
>  	struct acpi_bus_type *type =3D acpi_get_bus_type(dev);
> -	acpi_handle handle;
>  	int ret;
> =20
>  	ret =3D acpi_bind_one(dev, NULL);
>  	if (ret && type) {
> -		ret =3D type->find_device(dev, &handle);
> -		if (ret) {
> +		struct acpi_device *adev;
> +
> +		adev =3D type->find_companion(dev);
> +		if (!adev) {
>  			DBG("Unable to get handle for %s\n", dev_name(dev));
> +			ret =3D -ENODEV;
>  			goto out;
>  		}
> -		ret =3D acpi_bind_one(dev, handle);
> +		ret =3D acpi_bind_one(dev, adev->handle);
>  		if (ret)
>  			goto out;
>  	}
> Index: linux-pm/drivers/pci/pci-acpi.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -306,10 +306,9 @@ void acpi_pci_remove_bus(struct pci_bus
>  }
> =20
>  /* ACPI bus type */
> -static int acpi_pci_find_device(struct device *dev, acpi_handle *han=
dle)
> +static struct acpi_device *acpi_pci_find_companion(struct device *de=
v)
>  {
>  	struct pci_dev *pci_dev =3D to_pci_dev(dev);
> -	struct acpi_device *adev;
>  	bool check_children;
>  	u64 addr;
> =20
> @@ -322,13 +321,8 @@ static int acpi_pci_find_device(struct d
>  			|| pci_dev->hdr_type =3D=3D PCI_HEADER_TYPE_CARDBUS;
>  	/* Please ref to ACPI spec for the syntax of _ADR */
>  	addr =3D (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn=
);
> -	adev =3D acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
> +	return acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
>  				      check_children);
> -	if (adev) {
> -		*handle =3D adev->handle;
> -		return 0;
> -	}
> -	return -ENODEV;
>  }
> =20
>  static void pci_acpi_setup(struct device *dev)
> @@ -368,7 +362,7 @@ static bool pci_acpi_bus_match(struct de
>  static struct acpi_bus_type acpi_pci_bus =3D {
>  	.name =3D "PCI",
>  	.match =3D pci_acpi_bus_match,
> -	.find_device =3D acpi_pci_find_device,
> +	.find_companion =3D acpi_pci_find_companion,
>  	.setup =3D pci_acpi_setup,
>  	.cleanup =3D pci_acpi_cleanup,
>  };
> Index: linux-pm/drivers/pnp/pnpacpi/core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/pnp/pnpacpi/core.c
> +++ linux-pm/drivers/pnp/pnpacpi/core.c
> @@ -329,20 +329,11 @@ static int __init acpi_pnp_match(struct
>  	    && compare_pnp_id(pnp->id, acpi_device_hid(acpi));
>  }
> =20
> -static int __init acpi_pnp_find_device(struct device *dev, acpi_hand=
le * handle)
> +static struct acpi_device * __init acpi_pnp_find_companion(struct de=
vice *dev)
>  {
> -	struct device *adev;
> -	struct acpi_device *acpi;
> -
> -	adev =3D bus_find_device(&acpi_bus_type, NULL,
> -			       to_pnp_dev(dev), acpi_pnp_match);
> -	if (!adev)
> -		return -ENODEV;
> -
> -	acpi =3D to_acpi_device(adev);
> -	*handle =3D acpi->handle;
> -	put_device(adev);
> -	return 0;
> +	dev =3D bus_find_device(&acpi_bus_type, NULL, to_pnp_dev(dev),
> +			      acpi_pnp_match);

Why remove put_device here?
bus_find_device() increase dev's reference count when a dev is matched.

> +	return dev ? to_acpi_device(dev) : NULL;
>  }
> =20
>  /* complete initialization of a PNPACPI device includes having
> @@ -356,7 +347,7 @@ static bool acpi_pnp_bus_match(struct de
>  static struct acpi_bus_type __initdata acpi_pnp_bus =3D {
>  	.name	     =3D "PNP",
>  	.match	     =3D acpi_pnp_bus_match,
> -	.find_device =3D acpi_pnp_find_device,
> +	.find_companion =3D acpi_pnp_find_companion,
>  };
> =20
>  int pnpacpi_disabled __initdata;
> Index: linux-pm/drivers/usb/core/usb-acpi.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/usb/core/usb-acpi.c
> +++ linux-pm/drivers/usb/core/usb-acpi.c
> @@ -127,7 +127,7 @@ out:
>  	return ret;
>  }
> =20
> -static int usb_acpi_find_device(struct device *dev, acpi_handle *han=
dle)
> +static struct acpi_device *usb_acpi_find_companion(struct device *de=
v)
>  {
>  	struct usb_device *udev;
>  	acpi_handle *parent_handle;
> @@ -169,16 +169,15 @@ static int usb_acpi_find_device(struct d
>  				break;
>  			}
> =20
> -			return -ENODEV;
> +			return NULL;
>  		}
> =20
>  		/* root hub's parent is the usb hcd. */
> -		parent_handle =3D ACPI_HANDLE(dev->parent);
> -		*handle =3D acpi_get_child(parent_handle, udev->portnum);
> -		if (!*handle)
> -			return -ENODEV;
> -		return 0;
> +		return acpi_find_child_device(ACPI_COMPANION(dev->parent),
> +					      udev->portnum, false);
>  	} else if (is_usb_port(dev)) {
> +		struct acpi_device *adev =3D NULL;
> +
>  		sscanf(dev_name(dev), "port%d", &port_num);
>  		/* Get the struct usb_device point of port's hub */
>  		udev =3D to_usb_device(dev->parent->parent);
> @@ -194,26 +193,27 @@ static int usb_acpi_find_device(struct d
> =20
>  			raw_port_num =3D usb_hcd_find_raw_port_number(hcd,
>  				port_num);
> -			*handle =3D acpi_get_child(ACPI_HANDLE(&udev->dev),
> -				raw_port_num);
> -			if (!*handle)
> -				return -ENODEV;
> +			adev =3D acpi_find_child_device(ACPI_COMPANION(&udev->dev),
> +						      raw_port_num, false);
> +			if (!adev)
> +				return NULL;
>  		} else {
>  			parent_handle =3D
>  				usb_get_hub_port_acpi_handle(udev->parent,
>  				udev->portnum);
>  			if (!parent_handle)
> -				return -ENODEV;
> +				return NULL;
> =20
> -			*handle =3D acpi_get_child(parent_handle,	port_num);
> -			if (!*handle)
> -				return -ENODEV;
> +			acpi_bus_get_device(parent_handle, &adev);
> +			adev =3D acpi_find_child_device(adev, port_num, false);
> +			if (!adev)
> +				return NULL;
>  		}
> -		usb_acpi_check_port_connect_type(udev, *handle, port_num);
> -	} else
> -		return -ENODEV;
> +		usb_acpi_check_port_connect_type(udev, adev->handle, port_num);
> +		return adev;
> +	}
> =20
> -	return 0;
> +	return NULL;
>  }
> =20
>  static bool usb_acpi_bus_match(struct device *dev)
> @@ -224,7 +224,7 @@ static bool usb_acpi_bus_match(struct de
>  static struct acpi_bus_type usb_acpi_bus =3D {
>  	.name =3D "USB",
>  	.match =3D usb_acpi_bus_match,
> -	.find_device =3D usb_acpi_find_device,
> +	.find_companion =3D usb_acpi_find_companion,
>  };
> =20
>  int usb_acpi_register(void)
>=20


--=20
Best regards
Tianyu Lan
