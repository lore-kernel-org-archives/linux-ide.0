From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: (unknown)
Date: Sat, 22 Feb 2014 16:53:29 +0100
Message-ID: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBE4QUOMAKGQEHTVYHEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: 
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi all,

Here is v7 of my patchset for adding ahci-sunxi support. This is hopefully
the final final version of this set :)

Note I'm going on vacation for a week starting Monday, so if I'm not responding
that is why. Tejun if you feel some small cleanups are still necessary and
you don't want to wait for me to get back feel free to squash in any cleanups
you deem necessary.

This has been tested with Allwinner A10, Allwinner A20 and Freeware imx6x SoCs,
including suspend / resume. Note that the ahci_imx driver now also has imx53
sata support, it would be good if someone could test that with this series.


History:

v1, by Olliver Schinagl:
This was using the approach of having a platform device which probe method
creates a new child platform device which gets driven by ahci_platform.c,
as done by ahci_imx.c .

v2, by Hans de Goede:
Stand-alone platform driver based on Olliver's work

v3, by Hans de Goede:
patch-series, with 4 different parts
a) Make ahci_platform.c more generic, handle more then 1 clk, target pwr
   regulator
b) New ahci-sunxi code only populating ahci_platform_data, passed to
   ahci_platform.c to of_device_id matching.
c) Refactor ahci-imx code to work the same as the new ahci-sunxi code, this
   is the reason why v3 is an RFC, I'm waiting for the wandboard I ordered to
   arrive so that I can actually test this.
d) dts bindings for the sunxi ahci parts

v4, by Hans de Goede:
patch-series, with 5 different parts:
a) Make ahci_platform.c more generic, handle more then 1 clk, target pwr
   regulator
b) Turn parts of ahci_platform.c into a library for use by other drivers
c) New ahci-sunxi driver using the ahci_platform.c library functionality
d) Refactor ahci-imx code to work the same as the new ahci-sunxi code
e) dts bindings for the sunxi ahci parts

v5:
v4 + the following changes:
1) fsl,imx6q driver is now tested
2) fixed suspend / resume on fsl,imx6q
3) Modifed devicetree node naming to match dt spec
4) Reworked the busy waiting code in the sunxi-phy handling as suggested by
   Russell King

v6:
v5 rebased on top of 3.14-rc3 + the following changes
1) Added Roger Quadros' generic phy support series
2) Added a "ARM: sun4i: dt: Remove grouping + simple-bus for regulators" dts
   patch

v7:
v6 + the following changes:
1) Addressed all Tejun's review remarks:
  * Added function header comments to all exported ahci_platform functions
  * Added comments in some other places
  * Removed use of 2 empty lines to separate functions in some cases
  * Use devres to automatically call ahci_platform_put_resources on
    get_resource failure, probe failure and regular device remove
2) Dropped patches to move ahci_host_priv struct declaration to include/linux,
  this was a left-over from v3 and is no longer necessary
3) Updated Roger's "ata: ahci_platform: Manage SATA PHY" patch:
  * Update function header comments for the changes this makes
  * Drop the Kconfig PHY requires hack, my patch for the phy-core to always be
    built-in has been queued in Greg KH's tree, so this is no longer necessary.
4) Dropped Roger's "ata: ahci_platform: Add 'struct device' argument to ahci_platform_put_resources()"
  patch, ahci_platform_put_resources already has a device argument as result
  of it being changed into a devres release function

Tejun, can you please add patches 1-12 to your ata tree for 3.15 ?

Maxime, can you please add patch 13-15 to your dts tree for 3.15 ?

Thanks & Regards,

Hans
