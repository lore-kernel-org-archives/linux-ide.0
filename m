From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/4] ARM: sunxi: Add ahci-sunxi driver for
 Allwinner SoCs sata
Date: Sat,  4 Jan 2014 10:14:34 +0100
Message-ID: <1388826878-5602-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBDNCT6LAKGQEFHLNOPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi Tejun et al,

Here is the second version of the ahci-sunxi driver. Since Oliver is a bit low
on time atm, I've taken over the efforts to upstream this for now.

v1 was using the approach of having a platform device which probe method
creates a new child platform device which gets driven by ahci_platform.c,
as done by ahci_imx.c . This was rightfully frowned upon, so we've gone
looking for a better / cleaner solution.

The option of turning ahci_platform.c into a generic re-usable library to be
shared between different ahci platform drivers was considered and rejected.

Almost all functionality is already shared through libahci / ata-core,
ahci_platform.c really is just a few lines of glue-code generalized to be
shared for the simply ahci platform device case.

Modifying ahci_platform.c to be generic enough to cleanly handle more
complex platform ahci devices, results in much more complex code, which likely
will still need to be modified each time a new exotic platform device shows
up. There simply is not enough common code to share there, and making it
generic enough would grow the code to be larger then simply having stand-alone
platform drivers using libahci directly.

IOW I believe that the "last mile" of glue code  simply cannot be efficiently
generalized.

So I've decided avoiding the ahci_imx.c ugliness is best done by refactoring
ahci_sunxi.c into a stand-alone platform driver, like ie sata_highbank.c.

To put this in numbers, ahci_platform.c is 353 lines, ahci_sunxi.c using
the ahci_imx.c approach (which was using ahci_platform.c as a lib) was 305
lines + 12 new lines in ahci_platform.c. ahci_sunxi.c as a standalone driver
is 351 lines. And the old ahci_sunxi.c was missing proper suspend / resume
support.

Please review and if there are no remark add patch 1 + 2 to your tree for
Linus. The dts bits will be merged through Maxime Ripard's tree.

Thanks & Regards,

Hans
